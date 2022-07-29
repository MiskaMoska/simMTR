`ifndef             TEST_PARAMS__SVH
`define             TEST_PARAMS__SVH

`define             ALG_TYPE                "ftra"
`define             CASE_IDX                100
`define             PKT_NUM                 100
`define             PKT_MAX_LEN             8
`define             INJECT_RATE             0.01
`define             CLK_PERIOD              2

// targt NoC size and its boundary router number
`define             NOC_WIDTH               4 
`define             NOC_HEIGHT              4
`define             BR_NUM                  4

bit                 [3:0]                   brid_x[`BR_NUM] = '{3,0,1,2};
bit                 [3:0]                   brid_y[`BR_NUM] = '{1,2,2,2};

`endif