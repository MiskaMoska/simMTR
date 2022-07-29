typedef struct{
    bit [1:0] cid;
    bit [3:0] tnoc_rid_x,tnoc_rid_y,inoc_rid_x,inoc_rid_y;
}connect_table;

typedef struct{
    bit [3:0] nid_x,nid_y,bid_x,bid_y;
}bound_table;

connect_table ctab[4*`BR_NUM];
bound_table inbtab[`NOC_WIDTH*`NOC_HEIGHT],outbtab[`NOC_WIDTH*`NOC_HEIGHT];

function automatic void init_connect_table(ref connect_table ctab[4*`BR_NUM]);
    // `uvm_info("route_table","start initializing connect table",UVM_LOW)
    for(bit [2:0] i = 0; i < 4; i ++) begin
        for(bit [2:0] j = 0; j < `BR_NUM; j ++) begin
            int id = i * `BR_NUM + j;
            ctab[id].cid = i;
            ctab[id].tnoc_rid_x = brid_x[j];
            ctab[id].tnoc_rid_y = brid_y[j];
            ctab[id].inoc_rid_x = i[0] * 2 + j[0];
            ctab[id].inoc_rid_y = i[1] * 2 + j[1];
            // `uvm_info("route_table",$sformatf("inoc_rid_x:%0d",ctab[id].inoc_rid_x),UVM_LOW)
            // `uvm_info("route_table",$sformatf("inoc_rid_y:%0d",ctab[id].inoc_rid_y),UVM_LOW)
            // `uvm_info("route_table","\n",UVM_LOW)
        end
    end
    // `uvm_info("route_table","finish initializing connect table",UVM_LOW)
    // `uvm_fatal("route_table","end")
endfunction

function automatic void init_bound_table(ref bound_table inbtab[`NOC_WIDTH*`NOC_HEIGHT],outbtab[`NOC_WIDTH*`NOC_HEIGHT]);
        inbtab[0].nid_x = 0; inbtab[0].nid_y = 0; inbtab[0].bid_x = 0; inbtab[0].bid_y = 2;
        inbtab[1].nid_x = 0; inbtab[1].nid_y = 1; inbtab[1].bid_x = 0; inbtab[1].bid_y = 2;
        inbtab[2].nid_x = 0; inbtab[2].nid_y = 2; inbtab[2].bid_x = 0; inbtab[2].bid_y = 2;
        inbtab[3].nid_x = 0; inbtab[3].nid_y = 3; inbtab[3].bid_x = 0; inbtab[3].bid_y = 2;
        inbtab[4].nid_x = 1; inbtab[4].nid_y = 0; inbtab[4].bid_x = 1; inbtab[4].bid_y = 2;
        inbtab[5].nid_x = 1; inbtab[5].nid_y = 1; inbtab[5].bid_x = 1; inbtab[5].bid_y = 2;
        inbtab[6].nid_x = 1; inbtab[6].nid_y = 2; inbtab[6].bid_x = 1; inbtab[6].bid_y = 2;
        inbtab[7].nid_x = 1; inbtab[7].nid_y = 3; inbtab[7].bid_x = 1; inbtab[7].bid_y = 2;
        inbtab[8].nid_x = 2; inbtab[8].nid_y = 0; inbtab[8].bid_x = 2; inbtab[8].bid_y = 2;
        inbtab[9].nid_x = 2; inbtab[9].nid_y = 1; inbtab[9].bid_x = 2; inbtab[9].bid_y = 2;
        inbtab[10].nid_x = 2; inbtab[10].nid_y = 2; inbtab[10].bid_x = 2; inbtab[10].bid_y = 2;
        inbtab[11].nid_x = 2; inbtab[11].nid_y = 3; inbtab[11].bid_x = 2; inbtab[11].bid_y = 2;
        inbtab[12].nid_x = 3; inbtab[12].nid_y = 0; inbtab[12].bid_x = 3; inbtab[12].bid_y = 1;
        inbtab[13].nid_x = 3; inbtab[13].nid_y = 1; inbtab[13].bid_x = 3; inbtab[13].bid_y = 1;
        inbtab[14].nid_x = 3; inbtab[14].nid_y = 2; inbtab[14].bid_x = 3; inbtab[14].bid_y = 1;
        inbtab[15].nid_x = 3; inbtab[15].nid_y = 3; inbtab[15].bid_x = 3; inbtab[15].bid_y = 1;
        outbtab[0].nid_x = 0; outbtab[0].nid_y = 0; outbtab[0].bid_x = 0; outbtab[0].bid_y = 2;
        outbtab[1].nid_x = 0; outbtab[1].nid_y = 1; outbtab[1].bid_x = 0; outbtab[1].bid_y = 2;
        outbtab[2].nid_x = 0; outbtab[2].nid_y = 2; outbtab[2].bid_x = 0; outbtab[2].bid_y = 2;
        outbtab[3].nid_x = 0; outbtab[3].nid_y = 3; outbtab[3].bid_x = 0; outbtab[3].bid_y = 2;
        outbtab[4].nid_x = 1; outbtab[4].nid_y = 0; outbtab[4].bid_x = 1; outbtab[4].bid_y = 2;
        outbtab[5].nid_x = 1; outbtab[5].nid_y = 1; outbtab[5].bid_x = 1; outbtab[5].bid_y = 2;
        outbtab[6].nid_x = 1; outbtab[6].nid_y = 2; outbtab[6].bid_x = 1; outbtab[6].bid_y = 2;
        outbtab[7].nid_x = 1; outbtab[7].nid_y = 3; outbtab[7].bid_x = 1; outbtab[7].bid_y = 2;
        outbtab[8].nid_x = 2; outbtab[8].nid_y = 0; outbtab[8].bid_x = 3; outbtab[8].bid_y = 1;
        outbtab[9].nid_x = 2; outbtab[9].nid_y = 1; outbtab[9].bid_x = 3; outbtab[9].bid_y = 1;
        outbtab[10].nid_x = 2; outbtab[10].nid_y = 2; outbtab[10].bid_x = 2; outbtab[10].bid_y = 2;
        outbtab[11].nid_x = 2; outbtab[11].nid_y = 3; outbtab[11].bid_x = 2; outbtab[11].bid_y = 2;
        outbtab[12].nid_x = 3; outbtab[12].nid_y = 0; outbtab[12].bid_x = 3; outbtab[12].bid_y = 1;
        outbtab[13].nid_x = 3; outbtab[13].nid_y = 1; outbtab[13].bid_x = 3; outbtab[13].bid_y = 1;
        outbtab[14].nid_x = 3; outbtab[14].nid_y = 2; outbtab[14].bid_x = 2; outbtab[14].bid_y = 2;
        outbtab[15].nid_x = 3; outbtab[15].nid_y = 3; outbtab[15].bid_x = 2; outbtab[15].bid_y = 2;
endfunction



function automatic bit [7:0] look_up_ctab(bit [1:0] cid, bit [3:0] tnoc_rid_x, bit [3:0] tnoc_rid_y);
    foreach(ctab[i_item]) begin
        int i = i_item;
        if(ctab[i].cid == cid && 
            ctab[i].tnoc_rid_x == tnoc_rid_x &&
            ctab[i].tnoc_rid_y == tnoc_rid_y) // match
            return {ctab[i].inoc_rid_x,ctab[i].inoc_rid_y};
    end
    `uvm_fatal("route_table","cannot match router id at connect table")
endfunction

function automatic bit [7:0] look_up_inbtab(bit [3:0] nid_x,nid_y);
    foreach(inbtab[i_item]) begin
        int i = i_item;
        if(inbtab[i].nid_x == nid_x && inbtab[i].nid_y == nid_y)
            return {inbtab[i].bid_x,inbtab[i].bid_y};
    end
    `uvm_fatal("route_table","cannot match router id at inbound mapping table")
endfunction

function automatic bit [7:0] look_up_outbtab(bit [3:0] nid_x,nid_y);
    foreach(outbtab[i_item]) begin
        int i = i_item;
        if(outbtab[i].nid_x == nid_x && outbtab[i].nid_y == nid_y)
            return {outbtab[i].bid_x,outbtab[i].bid_y};
    end
    `uvm_fatal("route_table","cannot match router id at outbound mapping table")
endfunction
