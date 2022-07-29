`ifndef         __PARAMS_VH__
`define         __PARAMS_VH__

`define         DW                  64 //data width
`define         CN                  6 //channel number
`define         FIFO_DEPTH          8 //fifo in NoC
`define         FIFO_DEPTH_LOG      3
`define         BFIFO_DEPTH         8 //fifo in bound link
`define         BFIFO_DEPTH_LOG     3

`define         OUTBOUND_M          26 //whether go outbound
`define         DCID_H              25 //destination NoC ID
`define         DCID_L              24
`define         DRID_X_H            23 //destination router ID at destination NoC
`define         DRID_X_L            20
`define         DRID_Y_H            19 
`define         DRID_Y_L            16
`define         ITPDRID_X_H         15 //destination router ID at interposer NoC
`define         ITPDRID_X_L         12
`define         ITPDRID_Y_H         11
`define         ITPDRID_Y_L         8
`define         RTDRID_X_H          7 //router ID that is used to routing at all NoCs       
`define         RTDRID_X_L          4
`define         RTDRID_Y_H          3       
`define         RTDRID_Y_L          0

`define         HEAD                2'b00
`define         BODY                2'b01
`define         TAIL                2'b11

`endif