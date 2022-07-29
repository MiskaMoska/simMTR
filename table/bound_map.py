'''
Generate boundary mapping table for inter-chip routing
The table guides how to choose the boundary router for inbound/outbound packets
'''
import os
import sys

from sklearn import neighbors
import rewrite as rw
from tqdm import tqdm
from math import factorial as ft
import numpy as np
import networkx as nx
from copy import deepcopy

def get_min_num(dst):
    num = 1
    flag = dst[0]['distance']
    for i in range(1,len(dst)):
        if dst[i]['distance'] != flag:
            return num
        num += 1
    return num

def pre_scan(G,W,H,brl):
    '''
    This function scans all the nodes in the network and makes determinable mappings 
    The mapping means a node is connected to a particular boundary node
    '''

    # brc: boundary router container
    brc_ib = {} # inbound
    brc_ob = {} # outbound
    for br in brl:
        key_b = str(br[0]) + " " + str(br[1])
        brc_ob[key_b] = []
        brc_ib[key_b] = []

    # bmt: boundary mapping table
    bmt_ib = {} # inbound
    bmt_ob = {} # outbound

    # inbound scan
    for x in range(0,W):
        for y in range(0,H):
            print('\n\nAnalyzing node (',x,',',y,') for inbound mapping')

            ib_dn = (x,y,'local_o') # inbound destination node
            key_n = str(x) + " " + str(y)
            dst = [] # a temp list to reserve the distances
            onehot_key_b = ""

            cnt = 0
            for br in brl:
                key_b = str(br[0]) + " " + str(br[1])
                ib_sn = (br[0],br[1],'bound_i') # inbound source node
                if nx.has_path(G,ib_sn,ib_dn): # inbound reachable
                    temp_dict = dict(bound=key_b,distance=nx.shortest_path_length(G,source=ib_sn,target=ib_dn))
                    dst.append(temp_dict)
                    print('has path from bound (',br[0],',',br[1],') with path length:',temp_dict['distance'])
                    onehot_key_b = key_b
                    cnt += 1
                else:
                    print('does not have path from bound (',br[0],',',br[1],')')

            if cnt == 0: # no reachable bound
                print("Error:CDG not connected")
                sys.exit()
            
            if cnt == 1: # only one reachable bound
                print('\nnode has only one reachable bound')
                onehot_x = int(onehot_key_b.split()[0])
                onehot_y = int(onehot_key_b.split()[1])
                brc_ib[onehot_key_b].append((x,y,))
                bmt_ib[key_n] = [(onehot_x,onehot_y,)]

            else: # more than one reachable bound 
                print('\nnode has more than one reachable bound')
                dst.sort(key=lambda dict:dict['distance'],reverse=False)
                min_num = get_min_num(dst)
                if min_num > 1:
                    print('\nnode has more than one nearest reachable bound')
                    bmt_ib[key_n] = []
                    for m in range(min_num):
                        brc_ib[dst[m]['bound']].append((x,y,))
                        _x = int(dst[m]['bound'].split()[0]) 
                        _y = int(dst[m]['bound'].split()[1]) 
                        bmt_ib[key_n].append((_x,_y,))
                
                else:
                    print('\nnode has only one nearest reachable bound')
                    brc_ib[dst[0]['bound']].append((x,y))
                    _x = int(dst[0]['bound'].split()[0]) 
                    _y = int(dst[0]['bound'].split()[1]) 
                    bmt_ib[key_n] = [(_x,_y,)]

    # outbound scan
    for x in range(0,W):
        for y in range(0,H):
            print('\n\nAnalyzing node (',x,',',y,') for outbound mapping')

            ob_sn = (x,y,'local_i') # outbound source node
            key_n = str(x) + " " + str(y)
            dst = [] # a temp list to reserve the distances
            onehot_key_b = ""

            cnt = 0
            for br in brl:
                key_b = str(br[0]) + " " + str(br[1])
                ob_dn = (br[0],br[1],'bound_o') # outbound destination node
                if nx.has_path(G,ob_sn,ob_dn): # outbound reachable
                    temp_dict = dict(bound=key_b,distance=nx.shortest_path_length(G,source=ob_sn,target=ob_dn))
                    dst.append(temp_dict)
                    print('has path to bound (',br[0],',',br[1],') with path length:',temp_dict['distance'])
                    onehot_key_b = key_b
                    cnt += 1
                else:
                    print('does not have path to bound (',br[0],',',br[1],')')

            if cnt == 0: # no reachable bound
                print("Error:CDG not connected")
                sys.exit()
            
            if cnt == 1: # only one reachable bound
                print('\nnode has only one reachable bound')
                onehot_x = int(onehot_key_b.split()[0])
                onehot_y = int(onehot_key_b.split()[1])
                brc_ob[onehot_key_b].append((x,y,))
                bmt_ob[key_n] = [(onehot_x,onehot_y,)]

            else: # more than one reachable bound 
                print('\nnode has more than one reachable bound')
                dst.sort(key=lambda dict:dict['distance'],reverse=False)
                min_num = get_min_num(dst)
                if min_num > 1:
                    print('\nnode has more than one nearest reachable bound')
                    bmt_ob[key_n] = []
                    for m in range(min_num):
                        brc_ob[dst[m]['bound']].append((x,y,))
                        _x = int(dst[m]['bound'].split()[0]) 
                        _y = int(dst[m]['bound'].split()[1]) 
                        bmt_ob[key_n].append((_x,_y,))
                
                else:
                    print('\nnode has only one nearest reachable bound')
                    brc_ob[dst[0]['bound']].append((x,y))
                    _x = int(dst[0]['bound'].split()[0]) 
                    _y = int(dst[0]['bound'].split()[1]) 
                    bmt_ob[key_n] = [(_x,_y,)]

    return bmt_ib,bmt_ob,brc_ib,brc_ob

def post_scan(bmt,brc,brn):
    for dg in range(2,brn+1):
        for k,v in bmt.items():
            if len(v) == dg:
                tl = []
                for br in v:
                    key_b = str(br[0]) + " " + str(br[1])
                    tl.append(dict(key_n=k,br=br,key_b=key_b,num=len(brc[key_b])))
                tl.sort(key=lambda dict:dict['num'],reverse=False)
                bmt[k] = [tl[0]['br']]
                for i in range(1,len(tl)):
                    _x = int(k.split()[0])
                    _y = int(k.split()[1])
                    brc[tl[i]['key_b']].remove((_x,_y))



def gen_bound_tab(bmt_ib,bmt_ob):
    i = 0
    print('\n\n\n')
    print('function automatic void init_bound_table(ref bound_table inbtab[`NOC_WIDTH*`NOC_HEIGHT],outbtab[`NOC_WIDTH*`NOC_HEIGHT]);')
    for k,v in bmt_ib.items():
        nid_x = k.split()[0] # str
        nid_y = k.split()[1] # str
        bid_x = str(v[0][0])
        bid_y = str(v[0][1])
        print('\tinbtab['+str(i)+'].nid_x = '+nid_x+'; inbtab['+str(i)+'].nid_y = '+nid_y+'; inbtab['+str(i)+'].bid_x = '+bid_x+'; inbtab['+str(i)+'].bid_y = '+bid_y+';')
        i += 1
    i = 0
    # print('\n')
    for k,v in bmt_ob.items():
        nid_x = k.split()[0] # str
        nid_y = k.split()[1] # str
        bid_x = str(v[0][0])
        bid_y = str(v[0][1])
        print('\toutbtab['+str(i)+'].nid_x = '+nid_x+'; outbtab['+str(i)+'].nid_y = '+nid_y+'; outbtab['+str(i)+'].bid_x = '+bid_x+'; outbtab['+str(i)+'].bid_y = '+bid_y+';')
        i += 1
    print('endfunction')





