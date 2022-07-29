import os
import sys

from sklearn import neighbors
import rewrite as rw
from tqdm import tqdm
from math import factorial as ft
import numpy as np
import networkx as nx
from copy import deepcopy

def construct_cdg(W,H):
    '''
    This function constructs a base Mesh NoC(Network on Chip) CDG(Channel Dependency Graph) 
    The Network is default to adopt XY routing algorithm

    Return
    ---------------------
    type:   MultiDiGraph
    '''
    legal_node = ['left_i','left_o','right_i','right_o','up_i','up_o','down_i','down_o','local_i','local_o']
    legal_path = [['left_i','right_o'],['left_i','up_o'],['left_i','down_o'],['right_i','left_o'],['right_i','up_o'],['right_i','down_o'],['up_i','down_o'],['down_i','up_o'],['local_i','left_o'],['local_i','right_o'],['local_i','up_o'],['local_i','down_o'],['left_i','local_o'],['right_i','local_o'],['up_i','local_o'],['down_i','local_o']]

    G=nx.MultiDiGraph()
    for i in range(W):
        for j in range(H):
            for k in range(len(legal_node)):
                G.add_node((i,j,legal_node[k]))
            for k in range(len(legal_path)):
                G.add_edge((i,j,legal_path[k][0]),(i,j,legal_path[k][1]))

    for i in range(W-1):
        for j in range(H):
            G.add_edge((i,j,'right_o'),(i+1,j,'left_i'))
            G.add_edge((i+1,j,'left_o'),(i,j,'right_i'))

    for i in range(W):
        for j in range(H-1):
            G.add_edge((i,j+1,'up_o'),(i,j,'down_i'))
            G.add_edge((i,j,'down_o'),(i,j+1,'up_i'))

    if not rw.find_cycle(G):
        # print("Mesh construction done")
        return G
    print("Mesh construction failed")
    return None


def set_bound_router(G,brl):
    '''
    This function sets all the boundary routers according to router ID list
    Sensitive to the topology of he network
    '''
    for i in range(len(brl)):
        x = brl[i][0]
        y = brl[i][1]
        G.add_node((x,y,'bound_i'))
        G.add_node((x,y,'bound_o'))
        G.add_edge((x,y,'bound_i'),(x,y,'left_o'))
        G.add_edge((x,y,'bound_i'),(x,y,'right_o'))
        G.add_edge((x,y,'bound_i'),(x,y,'up_o'))
        G.add_edge((x,y,'bound_i'),(x,y,'down_o'))
        G.add_edge((x,y,'bound_i'),(x,y,'local_o'))
        G.add_edge((x,y,'left_i'),(x,y,'bound_o'))
        G.add_edge((x,y,'right_i'),(x,y,'bound_o'))
        G.add_edge((x,y,'up_i'),(x,y,'bound_o'))
        G.add_edge((x,y,'down_i'),(x,y,'bound_o'))
        G.add_edge((x,y,'local_i'),(x,y,'bound_o'))


def set_bound_restriction(G,btrl):
    '''
    This function places the boundary turn restrictions on the cdg
    '''
    for btr in btrl:
        G.remove_edge(btr[0],btr[1])