import os
import sys

from sklearn import neighbors
from mesh_cdg import *
from bound_map import *
from extraction import *
import rewrite as rw
from tqdm import tqdm
from math import factorial as ft
import numpy as np
import networkx as nx
from copy import deepcopy

NOC_WIDTH = 4
NOC_HEIGHT = 4
BR_NUM = 4
INDEX = 1010
PATH = 'F:/git/Fast-TRA/output_mesh_w' + str(NOC_WIDTH) + '_h' + str(NOC_HEIGHT) + '_n' + str(BR_NUM) + \
        '/mt_go0_mode32_r6.txt'

if __name__ == "__main__":
    CDG = construct_cdg(NOC_WIDTH,NOC_HEIGHT)
    brl,btrl = extract(BR_NUM,PATH,INDEX)
    set_bound_router(CDG,brl)
    set_bound_restriction(CDG,btrl)
    bmt_ib,bmt_ob,brc_ib,brc_ob = pre_scan(CDG,NOC_WIDTH,NOC_HEIGHT,brl)
    post_scan(bmt_ib,brc_ib,BR_NUM)
    post_scan(bmt_ob,brc_ob,BR_NUM)
    print('\n\ninbound mapping table\n')
    print('boundary router container:')
    for k,v in brc_ib.items():
        print(k,'-----',v)
    print('\nboundary mapping table:')
    for k,v in bmt_ib.items():
        print(k,'-----',v)

    print('\n\noutbound mapping table')
    print('boundary router container:')
    for k,v in brc_ob.items():
        print(k,'-----',v)
    print('\nboundary mapping table:')
    for k,v in bmt_ob.items():
        print(k,'-----',v)

    print('\n\nbrl:',brl)
    print('btrl:')
    for i in btrl:
        print(i)

    gen_bound_tab(bmt_ib,bmt_ob)




    
