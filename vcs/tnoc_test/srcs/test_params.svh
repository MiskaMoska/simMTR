`ifndef             TEST_PARAMS__SVH
`define             TEST_PARAMS__SVH

`define             PKT_NUM                 1000
`define             PKT_MAX_LEN             16

`define             NOC_WIDTH               4
`define             NOC_HEIGHT              4
`define             BR_NUM                  3

bit                 [3:0]                   brid_x[`BR_NUM] = '{2,1,3};
bit                 [3:0]                   brid_y[`BR_NUM] = '{0,3,2};

`endif