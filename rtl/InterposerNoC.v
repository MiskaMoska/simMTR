//Network on Chip
//Width: 4
//Height:4
`include "params.vh"

module InterposerNoC #(
    parameter CID = 0
)(
    input       wire                            clk,
    input       wire                            rstn,
    
    //router0
    input       wire        [`DW-1:0]           data_i_0_0,
    input       wire                            valid_i_0_0,
    output      wire                            ready_o_0_0,

    output      wire        [`DW-1:0]           data_o_0_0,
    output      wire                            valid_o_0_0,
    input       wire                            ready_i_0_0,

    //router1
    input       wire        [`DW-1:0]           data_i_1_0,
    input       wire                            valid_i_1_0,
    output      wire                            ready_o_1_0,

    output      wire        [`DW-1:0]           data_o_1_0,
    output      wire                            valid_o_1_0,
    input       wire                            ready_i_1_0,

    //router2
    input       wire        [`DW-1:0]           data_i_2_0,
    input       wire                            valid_i_2_0,
    output      wire                            ready_o_2_0,

    output      wire        [`DW-1:0]           data_o_2_0,
    output      wire                            valid_o_2_0,
    input       wire                            ready_i_2_0,

    //router3
    input       wire        [`DW-1:0]           data_i_3_0,
    input       wire                            valid_i_3_0,
    output      wire                            ready_o_3_0,

    output      wire        [`DW-1:0]           data_o_3_0,
    output      wire                            valid_o_3_0,
    input       wire                            ready_i_3_0,

    //router4
    input       wire        [`DW-1:0]           data_i_0_1,
    input       wire                            valid_i_0_1,
    output      wire                            ready_o_0_1,

    output      wire        [`DW-1:0]           data_o_0_1,
    output      wire                            valid_o_0_1,
    input       wire                            ready_i_0_1,

    //router5
    input       wire        [`DW-1:0]           data_i_1_1,
    input       wire                            valid_i_1_1,
    output      wire                            ready_o_1_1,

    output      wire        [`DW-1:0]           data_o_1_1,
    output      wire                            valid_o_1_1,
    input       wire                            ready_i_1_1,

    //router6
    input       wire        [`DW-1:0]           data_i_2_1,
    input       wire                            valid_i_2_1,
    output      wire                            ready_o_2_1,

    output      wire        [`DW-1:0]           data_o_2_1,
    output      wire                            valid_o_2_1,
    input       wire                            ready_i_2_1,

    //router7
    input       wire        [`DW-1:0]           data_i_3_1,
    input       wire                            valid_i_3_1,
    output      wire                            ready_o_3_1,

    output      wire        [`DW-1:0]           data_o_3_1,
    output      wire                            valid_o_3_1,
    input       wire                            ready_i_3_1,

    //router8
    input       wire        [`DW-1:0]           data_i_0_2,
    input       wire                            valid_i_0_2,
    output      wire                            ready_o_0_2,

    output      wire        [`DW-1:0]           data_o_0_2,
    output      wire                            valid_o_0_2,
    input       wire                            ready_i_0_2,

    //router9
    input       wire        [`DW-1:0]           data_i_1_2,
    input       wire                            valid_i_1_2,
    output      wire                            ready_o_1_2,

    output      wire        [`DW-1:0]           data_o_1_2,
    output      wire                            valid_o_1_2,
    input       wire                            ready_i_1_2,

    //router10
    input       wire        [`DW-1:0]           data_i_2_2,
    input       wire                            valid_i_2_2,
    output      wire                            ready_o_2_2,

    output      wire        [`DW-1:0]           data_o_2_2,
    output      wire                            valid_o_2_2,
    input       wire                            ready_i_2_2,

    //router11
    input       wire        [`DW-1:0]           data_i_3_2,
    input       wire                            valid_i_3_2,
    output      wire                            ready_o_3_2,

    output      wire        [`DW-1:0]           data_o_3_2,
    output      wire                            valid_o_3_2,
    input       wire                            ready_i_3_2,

    //router12
    input       wire        [`DW-1:0]           data_i_0_3,
    input       wire                            valid_i_0_3,
    output      wire                            ready_o_0_3,

    output      wire        [`DW-1:0]           data_o_0_3,
    output      wire                            valid_o_0_3,
    input       wire                            ready_i_0_3,

    //router13
    input       wire        [`DW-1:0]           data_i_1_3,
    input       wire                            valid_i_1_3,
    output      wire                            ready_o_1_3,

    output      wire        [`DW-1:0]           data_o_1_3,
    output      wire                            valid_o_1_3,
    input       wire                            ready_i_1_3,

    //router14
    input       wire        [`DW-1:0]           data_i_2_3,
    input       wire                            valid_i_2_3,
    output      wire                            ready_o_2_3,

    output      wire        [`DW-1:0]           data_o_2_3,
    output      wire                            valid_o_2_3,
    input       wire                            ready_i_2_3,

    //router15
    input       wire        [`DW-1:0]           data_i_3_3,
    input       wire                            valid_i_3_3,
    output      wire                            ready_o_3_3,

    output      wire        [`DW-1:0]           data_o_3_3,
    output      wire                            valid_o_3_3,
    input       wire                            ready_i_3_3
);

//horizontal signals
wire    [`DW-1:0]   data_0_to_1,	data_1_to_0;
wire                valid_0_to_1,	valid_1_to_0;
wire                ready_0_to_1,	ready_1_to_0;
wire    [`DW-1:0]   data_1_to_2,	data_2_to_1;
wire                valid_1_to_2,	valid_2_to_1;
wire                ready_1_to_2,	ready_2_to_1;
wire    [`DW-1:0]   data_2_to_3,	data_3_to_2;
wire                valid_2_to_3,	valid_3_to_2;
wire                ready_2_to_3,	ready_3_to_2;
wire    [`DW-1:0]   data_4_to_5,	data_5_to_4;
wire                valid_4_to_5,	valid_5_to_4;
wire                ready_4_to_5,	ready_5_to_4;
wire    [`DW-1:0]   data_5_to_6,	data_6_to_5;
wire                valid_5_to_6,	valid_6_to_5;
wire                ready_5_to_6,	ready_6_to_5;
wire    [`DW-1:0]   data_6_to_7,	data_7_to_6;
wire                valid_6_to_7,	valid_7_to_6;
wire                ready_6_to_7,	ready_7_to_6;
wire    [`DW-1:0]   data_8_to_9,	data_9_to_8;
wire                valid_8_to_9,	valid_9_to_8;
wire                ready_8_to_9,	ready_9_to_8;
wire    [`DW-1:0]   data_9_to_10,	data_10_to_9;
wire                valid_9_to_10,	valid_10_to_9;
wire                ready_9_to_10,	ready_10_to_9;
wire    [`DW-1:0]   data_10_to_11,	data_11_to_10;
wire                valid_10_to_11,	valid_11_to_10;
wire                ready_10_to_11,	ready_11_to_10;
wire    [`DW-1:0]   data_12_to_13,	data_13_to_12;
wire                valid_12_to_13,	valid_13_to_12;
wire                ready_12_to_13,	ready_13_to_12;
wire    [`DW-1:0]   data_13_to_14,	data_14_to_13;
wire                valid_13_to_14,	valid_14_to_13;
wire                ready_13_to_14,	ready_14_to_13;
wire    [`DW-1:0]   data_14_to_15,	data_15_to_14;
wire                valid_14_to_15,	valid_15_to_14;
wire                ready_14_to_15,	ready_15_to_14;

//vertical signals
wire    [`DW-1:0]   data_0_to_4,	data_4_to_0;
wire                valid_0_to_4,	valid_4_to_0;
wire                ready_0_to_4,	ready_4_to_0;
wire    [`DW-1:0]   data_4_to_8,	data_8_to_4;
wire                valid_4_to_8,	valid_8_to_4;
wire                ready_4_to_8,	ready_8_to_4;
wire    [`DW-1:0]   data_8_to_12,	data_12_to_8;
wire                valid_8_to_12,	valid_12_to_8;
wire                ready_8_to_12,	ready_12_to_8;
wire    [`DW-1:0]   data_1_to_5,	data_5_to_1;
wire                valid_1_to_5,	valid_5_to_1;
wire                ready_1_to_5,	ready_5_to_1;
wire    [`DW-1:0]   data_5_to_9,	data_9_to_5;
wire                valid_5_to_9,	valid_9_to_5;
wire                ready_5_to_9,	ready_9_to_5;
wire    [`DW-1:0]   data_9_to_13,	data_13_to_9;
wire                valid_9_to_13,	valid_13_to_9;
wire                ready_9_to_13,	ready_13_to_9;
wire    [`DW-1:0]   data_2_to_6,	data_6_to_2;
wire                valid_2_to_6,	valid_6_to_2;
wire                ready_2_to_6,	ready_6_to_2;
wire    [`DW-1:0]   data_6_to_10,	data_10_to_6;
wire                valid_6_to_10,	valid_10_to_6;
wire                ready_6_to_10,	ready_10_to_6;
wire    [`DW-1:0]   data_10_to_14,	data_14_to_10;
wire                valid_10_to_14,	valid_14_to_10;
wire                ready_10_to_14,	ready_14_to_10;
wire    [`DW-1:0]   data_3_to_7,	data_7_to_3;
wire                valid_3_to_7,	valid_7_to_3;
wire                ready_3_to_7,	ready_7_to_3;
wire    [`DW-1:0]   data_7_to_11,	data_11_to_7;
wire                valid_7_to_11,	valid_11_to_7;
wire                ready_7_to_11,	ready_11_to_7;
wire    [`DW-1:0]   data_11_to_15,	data_15_to_11;
wire                valid_11_to_15,	valid_15_to_11;
wire                ready_11_to_15,	ready_15_to_11;
    
router #(
    .LocalRID_X            (0),
    .LocalRID_Y            (0)
)router0(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (64'b0),
    .west_valid_i          (1'b0),
    .west_ready_o          (),
    .west_data_o           (),
    .west_valid_o          (),
    .west_ready_i          (1'b0),
    .east_data_i           (data_1_to_0),
    .east_valid_i          (valid_1_to_0),
    .east_ready_o          (ready_0_to_1),
    .east_data_o           (data_0_to_1),
    .east_valid_o          (valid_0_to_1),
    .east_ready_i          (ready_1_to_0),
    .north_data_i          (64'b0),
    .north_valid_i         (1'b0),
    .north_ready_o         (),
    .north_data_o          (),
    .north_valid_o         (),
    .north_ready_i         (1'b0),
    .south_data_i          (data_4_to_0),
    .south_valid_i         (valid_4_to_0),
    .south_ready_o         (ready_0_to_4),
    .south_data_o          (data_0_to_4),
    .south_valid_o         (valid_0_to_4),
    .south_ready_i         (ready_4_to_0),
    .local_data_i          (data_i_0_0),
    .local_valid_i         (valid_i_0_0),
    .local_ready_o         (ready_o_0_0),
    .local_data_o          (data_o_0_0),
    .local_valid_o         (valid_o_0_0),
    .local_ready_i         (ready_i_0_0),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (1),
    .LocalRID_Y            (0)
)router1(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_0_to_1),
    .west_valid_i          (valid_0_to_1),
    .west_ready_o          (ready_1_to_0),
    .west_data_o           (data_1_to_0),
    .west_valid_o          (valid_1_to_0),
    .west_ready_i          (ready_0_to_1),
    .east_data_i           (data_2_to_1),
    .east_valid_i          (valid_2_to_1),
    .east_ready_o          (ready_1_to_2),
    .east_data_o           (data_1_to_2),
    .east_valid_o          (valid_1_to_2),
    .east_ready_i          (ready_2_to_1),
    .north_data_i          (64'b0),
    .north_valid_i         (1'b0),
    .north_ready_o         (),
    .north_data_o          (),
    .north_valid_o         (),
    .north_ready_i         (1'b0),
    .south_data_i          (data_5_to_1),
    .south_valid_i         (valid_5_to_1),
    .south_ready_o         (ready_1_to_5),
    .south_data_o          (data_1_to_5),
    .south_valid_o         (valid_1_to_5),
    .south_ready_i         (ready_5_to_1),
    .local_data_i          (data_i_1_0),
    .local_valid_i         (valid_i_1_0),
    .local_ready_o         (ready_o_1_0),
    .local_data_o          (data_o_1_0),
    .local_valid_o         (valid_o_1_0),
    .local_ready_i         (ready_i_1_0),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (2),
    .LocalRID_Y            (0)
)router2(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_1_to_2),
    .west_valid_i          (valid_1_to_2),
    .west_ready_o          (ready_2_to_1),
    .west_data_o           (data_2_to_1),
    .west_valid_o          (valid_2_to_1),
    .west_ready_i          (ready_1_to_2),
    .east_data_i           (data_3_to_2),
    .east_valid_i          (valid_3_to_2),
    .east_ready_o          (ready_2_to_3),
    .east_data_o           (data_2_to_3),
    .east_valid_o          (valid_2_to_3),
    .east_ready_i          (ready_3_to_2),
    .north_data_i          (64'b0),
    .north_valid_i         (1'b0),
    .north_ready_o         (),
    .north_data_o          (),
    .north_valid_o         (),
    .north_ready_i         (1'b0),
    .south_data_i          (data_6_to_2),
    .south_valid_i         (valid_6_to_2),
    .south_ready_o         (ready_2_to_6),
    .south_data_o          (data_2_to_6),
    .south_valid_o         (valid_2_to_6),
    .south_ready_i         (ready_6_to_2),
    .local_data_i          (data_i_2_0),
    .local_valid_i         (valid_i_2_0),
    .local_ready_o         (ready_o_2_0),
    .local_data_o          (data_o_2_0),
    .local_valid_o         (valid_o_2_0),
    .local_ready_i         (ready_i_2_0),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (3),
    .LocalRID_Y            (0)
)router3(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_2_to_3),
    .west_valid_i          (valid_2_to_3),
    .west_ready_o          (ready_3_to_2),
    .west_data_o           (data_3_to_2),
    .west_valid_o          (valid_3_to_2),
    .west_ready_i          (ready_2_to_3),
    .east_data_i           (64'b0),
    .east_valid_i          (1'b0),
    .east_ready_o          (),
    .east_data_o           (),
    .east_valid_o          (),
    .east_ready_i          (1'b0),
    .north_data_i          (64'b0),
    .north_valid_i         (1'b0),
    .north_ready_o         (),
    .north_data_o          (),
    .north_valid_o         (),
    .north_ready_i         (1'b0),
    .south_data_i          (data_7_to_3),
    .south_valid_i         (valid_7_to_3),
    .south_ready_o         (ready_3_to_7),
    .south_data_o          (data_3_to_7),
    .south_valid_o         (valid_3_to_7),
    .south_ready_i         (ready_7_to_3),
    .local_data_i          (data_i_3_0),
    .local_valid_i         (valid_i_3_0),
    .local_ready_o         (ready_o_3_0),
    .local_data_o          (data_o_3_0),
    .local_valid_o         (valid_o_3_0),
    .local_ready_i         (ready_i_3_0),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (0),
    .LocalRID_Y            (1)
)router4(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (64'b0),
    .west_valid_i          (1'b0),
    .west_ready_o          (),
    .west_data_o           (),
    .west_valid_o          (),
    .west_ready_i          (1'b0),
    .east_data_i           (data_5_to_4),
    .east_valid_i          (valid_5_to_4),
    .east_ready_o          (ready_4_to_5),
    .east_data_o           (data_4_to_5),
    .east_valid_o          (valid_4_to_5),
    .east_ready_i          (ready_5_to_4),
    .north_data_i          (data_0_to_4),
    .north_valid_i         (valid_0_to_4),
    .north_ready_o         (ready_4_to_0),
    .north_data_o          (data_4_to_0),
    .north_valid_o         (valid_4_to_0),
    .north_ready_i         (ready_0_to_4),
    .south_data_i          (data_8_to_4),
    .south_valid_i         (valid_8_to_4),
    .south_ready_o         (ready_4_to_8),
    .south_data_o          (data_4_to_8),
    .south_valid_o         (valid_4_to_8),
    .south_ready_i         (ready_8_to_4),
    .local_data_i          (data_i_0_1),
    .local_valid_i         (valid_i_0_1),
    .local_ready_o         (ready_o_0_1),
    .local_data_o          (data_o_0_1),
    .local_valid_o         (valid_o_0_1),
    .local_ready_i         (ready_i_0_1),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (1),
    .LocalRID_Y            (1)
)router5(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_4_to_5),
    .west_valid_i          (valid_4_to_5),
    .west_ready_o          (ready_5_to_4),
    .west_data_o           (data_5_to_4),
    .west_valid_o          (valid_5_to_4),
    .west_ready_i          (ready_4_to_5),
    .east_data_i           (data_6_to_5),
    .east_valid_i          (valid_6_to_5),
    .east_ready_o          (ready_5_to_6),
    .east_data_o           (data_5_to_6),
    .east_valid_o          (valid_5_to_6),
    .east_ready_i          (ready_6_to_5),
    .north_data_i          (data_1_to_5),
    .north_valid_i         (valid_1_to_5),
    .north_ready_o         (ready_5_to_1),
    .north_data_o          (data_5_to_1),
    .north_valid_o         (valid_5_to_1),
    .north_ready_i         (ready_1_to_5),
    .south_data_i          (data_9_to_5),
    .south_valid_i         (valid_9_to_5),
    .south_ready_o         (ready_5_to_9),
    .south_data_o          (data_5_to_9),
    .south_valid_o         (valid_5_to_9),
    .south_ready_i         (ready_9_to_5),
    .local_data_i          (data_i_1_1),
    .local_valid_i         (valid_i_1_1),
    .local_ready_o         (ready_o_1_1),
    .local_data_o          (data_o_1_1),
    .local_valid_o         (valid_o_1_1),
    .local_ready_i         (ready_i_1_1),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (2),
    .LocalRID_Y            (1)
)router6(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_5_to_6),
    .west_valid_i          (valid_5_to_6),
    .west_ready_o          (ready_6_to_5),
    .west_data_o           (data_6_to_5),
    .west_valid_o          (valid_6_to_5),
    .west_ready_i          (ready_5_to_6),
    .east_data_i           (data_7_to_6),
    .east_valid_i          (valid_7_to_6),
    .east_ready_o          (ready_6_to_7),
    .east_data_o           (data_6_to_7),
    .east_valid_o          (valid_6_to_7),
    .east_ready_i          (ready_7_to_6),
    .north_data_i          (data_2_to_6),
    .north_valid_i         (valid_2_to_6),
    .north_ready_o         (ready_6_to_2),
    .north_data_o          (data_6_to_2),
    .north_valid_o         (valid_6_to_2),
    .north_ready_i         (ready_2_to_6),
    .south_data_i          (data_10_to_6),
    .south_valid_i         (valid_10_to_6),
    .south_ready_o         (ready_6_to_10),
    .south_data_o          (data_6_to_10),
    .south_valid_o         (valid_6_to_10),
    .south_ready_i         (ready_10_to_6),
    .local_data_i          (data_i_2_1),
    .local_valid_i         (valid_i_2_1),
    .local_ready_o         (ready_o_2_1),
    .local_data_o          (data_o_2_1),
    .local_valid_o         (valid_o_2_1),
    .local_ready_i         (ready_i_2_1),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (3),
    .LocalRID_Y            (1)
)router7(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_6_to_7),
    .west_valid_i          (valid_6_to_7),
    .west_ready_o          (ready_7_to_6),
    .west_data_o           (data_7_to_6),
    .west_valid_o          (valid_7_to_6),
    .west_ready_i          (ready_6_to_7),
    .east_data_i           (64'b0),
    .east_valid_i          (1'b0),
    .east_ready_o          (),
    .east_data_o           (),
    .east_valid_o          (),
    .east_ready_i          (1'b0),
    .north_data_i          (data_3_to_7),
    .north_valid_i         (valid_3_to_7),
    .north_ready_o         (ready_7_to_3),
    .north_data_o          (data_7_to_3),
    .north_valid_o         (valid_7_to_3),
    .north_ready_i         (ready_3_to_7),
    .south_data_i          (data_11_to_7),
    .south_valid_i         (valid_11_to_7),
    .south_ready_o         (ready_7_to_11),
    .south_data_o          (data_7_to_11),
    .south_valid_o         (valid_7_to_11),
    .south_ready_i         (ready_11_to_7),
    .local_data_i          (data_i_3_1),
    .local_valid_i         (valid_i_3_1),
    .local_ready_o         (ready_o_3_1),
    .local_data_o          (data_o_3_1),
    .local_valid_o         (valid_o_3_1),
    .local_ready_i         (ready_i_3_1),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (0),
    .LocalRID_Y            (2)
)router8(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (64'b0),
    .west_valid_i          (1'b0),
    .west_ready_o          (),
    .west_data_o           (),
    .west_valid_o          (),
    .west_ready_i          (1'b0),
    .east_data_i           (data_9_to_8),
    .east_valid_i          (valid_9_to_8),
    .east_ready_o          (ready_8_to_9),
    .east_data_o           (data_8_to_9),
    .east_valid_o          (valid_8_to_9),
    .east_ready_i          (ready_9_to_8),
    .north_data_i          (data_4_to_8),
    .north_valid_i         (valid_4_to_8),
    .north_ready_o         (ready_8_to_4),
    .north_data_o          (data_8_to_4),
    .north_valid_o         (valid_8_to_4),
    .north_ready_i         (ready_4_to_8),
    .south_data_i          (data_12_to_8),
    .south_valid_i         (valid_12_to_8),
    .south_ready_o         (ready_8_to_12),
    .south_data_o          (data_8_to_12),
    .south_valid_o         (valid_8_to_12),
    .south_ready_i         (ready_12_to_8),
    .local_data_i          (data_i_0_2),
    .local_valid_i         (valid_i_0_2),
    .local_ready_o         (ready_o_0_2),
    .local_data_o          (data_o_0_2),
    .local_valid_o         (valid_o_0_2),
    .local_ready_i         (ready_i_0_2),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (1),
    .LocalRID_Y            (2)
)router9(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_8_to_9),
    .west_valid_i          (valid_8_to_9),
    .west_ready_o          (ready_9_to_8),
    .west_data_o           (data_9_to_8),
    .west_valid_o          (valid_9_to_8),
    .west_ready_i          (ready_8_to_9),
    .east_data_i           (data_10_to_9),
    .east_valid_i          (valid_10_to_9),
    .east_ready_o          (ready_9_to_10),
    .east_data_o           (data_9_to_10),
    .east_valid_o          (valid_9_to_10),
    .east_ready_i          (ready_10_to_9),
    .north_data_i          (data_5_to_9),
    .north_valid_i         (valid_5_to_9),
    .north_ready_o         (ready_9_to_5),
    .north_data_o          (data_9_to_5),
    .north_valid_o         (valid_9_to_5),
    .north_ready_i         (ready_5_to_9),
    .south_data_i          (data_13_to_9),
    .south_valid_i         (valid_13_to_9),
    .south_ready_o         (ready_9_to_13),
    .south_data_o          (data_9_to_13),
    .south_valid_o         (valid_9_to_13),
    .south_ready_i         (ready_13_to_9),
    .local_data_i          (data_i_1_2),
    .local_valid_i         (valid_i_1_2),
    .local_ready_o         (ready_o_1_2),
    .local_data_o          (data_o_1_2),
    .local_valid_o         (valid_o_1_2),
    .local_ready_i         (ready_i_1_2),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (2),
    .LocalRID_Y            (2)
)router10(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_9_to_10),
    .west_valid_i          (valid_9_to_10),
    .west_ready_o          (ready_10_to_9),
    .west_data_o           (data_10_to_9),
    .west_valid_o          (valid_10_to_9),
    .west_ready_i          (ready_9_to_10),
    .east_data_i           (data_11_to_10),
    .east_valid_i          (valid_11_to_10),
    .east_ready_o          (ready_10_to_11),
    .east_data_o           (data_10_to_11),
    .east_valid_o          (valid_10_to_11),
    .east_ready_i          (ready_11_to_10),
    .north_data_i          (data_6_to_10),
    .north_valid_i         (valid_6_to_10),
    .north_ready_o         (ready_10_to_6),
    .north_data_o          (data_10_to_6),
    .north_valid_o         (valid_10_to_6),
    .north_ready_i         (ready_6_to_10),
    .south_data_i          (data_14_to_10),
    .south_valid_i         (valid_14_to_10),
    .south_ready_o         (ready_10_to_14),
    .south_data_o          (data_10_to_14),
    .south_valid_o         (valid_10_to_14),
    .south_ready_i         (ready_14_to_10),
    .local_data_i          (data_i_2_2),
    .local_valid_i         (valid_i_2_2),
    .local_ready_o         (ready_o_2_2),
    .local_data_o          (data_o_2_2),
    .local_valid_o         (valid_o_2_2),
    .local_ready_i         (ready_i_2_2),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (3),
    .LocalRID_Y            (2)
)router11(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_10_to_11),
    .west_valid_i          (valid_10_to_11),
    .west_ready_o          (ready_11_to_10),
    .west_data_o           (data_11_to_10),
    .west_valid_o          (valid_11_to_10),
    .west_ready_i          (ready_10_to_11),
    .east_data_i           (64'b0),
    .east_valid_i          (1'b0),
    .east_ready_o          (),
    .east_data_o           (),
    .east_valid_o          (),
    .east_ready_i          (1'b0),
    .north_data_i          (data_7_to_11),
    .north_valid_i         (valid_7_to_11),
    .north_ready_o         (ready_11_to_7),
    .north_data_o          (data_11_to_7),
    .north_valid_o         (valid_11_to_7),
    .north_ready_i         (ready_7_to_11),
    .south_data_i          (data_15_to_11),
    .south_valid_i         (valid_15_to_11),
    .south_ready_o         (ready_11_to_15),
    .south_data_o          (data_11_to_15),
    .south_valid_o         (valid_11_to_15),
    .south_ready_i         (ready_15_to_11),
    .local_data_i          (data_i_3_2),
    .local_valid_i         (valid_i_3_2),
    .local_ready_o         (ready_o_3_2),
    .local_data_o          (data_o_3_2),
    .local_valid_o         (valid_o_3_2),
    .local_ready_i         (ready_i_3_2),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (0),
    .LocalRID_Y            (3)
)router12(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (64'b0),
    .west_valid_i          (1'b0),
    .west_ready_o          (),
    .west_data_o           (),
    .west_valid_o          (),
    .west_ready_i          (1'b0),
    .east_data_i           (data_13_to_12),
    .east_valid_i          (valid_13_to_12),
    .east_ready_o          (ready_12_to_13),
    .east_data_o           (data_12_to_13),
    .east_valid_o          (valid_12_to_13),
    .east_ready_i          (ready_13_to_12),
    .north_data_i          (data_8_to_12),
    .north_valid_i         (valid_8_to_12),
    .north_ready_o         (ready_12_to_8),
    .north_data_o          (data_12_to_8),
    .north_valid_o         (valid_12_to_8),
    .north_ready_i         (ready_8_to_12),
    .south_data_i          (64'b0),
    .south_valid_i         (1'b0),
    .south_ready_o         (),
    .south_data_o          (),
    .south_valid_o         (),
    .south_ready_i         (1'b0),
    .local_data_i          (data_i_0_3),
    .local_valid_i         (valid_i_0_3),
    .local_ready_o         (ready_o_0_3),
    .local_data_o          (data_o_0_3),
    .local_valid_o         (valid_o_0_3),
    .local_ready_i         (ready_i_0_3),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (1),
    .LocalRID_Y            (3)
)router13(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_12_to_13),
    .west_valid_i          (valid_12_to_13),
    .west_ready_o          (ready_13_to_12),
    .west_data_o           (data_13_to_12),
    .west_valid_o          (valid_13_to_12),
    .west_ready_i          (ready_12_to_13),
    .east_data_i           (data_14_to_13),
    .east_valid_i          (valid_14_to_13),
    .east_ready_o          (ready_13_to_14),
    .east_data_o           (data_13_to_14),
    .east_valid_o          (valid_13_to_14),
    .east_ready_i          (ready_14_to_13),
    .north_data_i          (data_9_to_13),
    .north_valid_i         (valid_9_to_13),
    .north_ready_o         (ready_13_to_9),
    .north_data_o          (data_13_to_9),
    .north_valid_o         (valid_13_to_9),
    .north_ready_i         (ready_9_to_13),
    .south_data_i          (64'b0),
    .south_valid_i         (1'b0),
    .south_ready_o         (),
    .south_data_o          (),
    .south_valid_o         (),
    .south_ready_i         (1'b0),
    .local_data_i          (data_i_1_3),
    .local_valid_i         (valid_i_1_3),
    .local_ready_o         (ready_o_1_3),
    .local_data_o          (data_o_1_3),
    .local_valid_o         (valid_o_1_3),
    .local_ready_i         (ready_i_1_3),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (2),
    .LocalRID_Y            (3)
)router14(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_13_to_14),
    .west_valid_i          (valid_13_to_14),
    .west_ready_o          (ready_14_to_13),
    .west_data_o           (data_14_to_13),
    .west_valid_o          (valid_14_to_13),
    .west_ready_i          (ready_13_to_14),
    .east_data_i           (data_15_to_14),
    .east_valid_i          (valid_15_to_14),
    .east_ready_o          (ready_14_to_15),
    .east_data_o           (data_14_to_15),
    .east_valid_o          (valid_14_to_15),
    .east_ready_i          (ready_15_to_14),
    .north_data_i          (data_10_to_14),
    .north_valid_i         (valid_10_to_14),
    .north_ready_o         (ready_14_to_10),
    .north_data_o          (data_14_to_10),
    .north_valid_o         (valid_14_to_10),
    .north_ready_i         (ready_10_to_14),
    .south_data_i          (64'b0),
    .south_valid_i         (1'b0),
    .south_ready_o         (),
    .south_data_o          (),
    .south_valid_o         (),
    .south_ready_i         (1'b0),
    .local_data_i          (data_i_2_3),
    .local_valid_i         (valid_i_2_3),
    .local_ready_o         (ready_o_2_3),
    .local_data_o          (data_o_2_3),
    .local_valid_o         (valid_o_2_3),
    .local_ready_i         (ready_i_2_3),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);
    
router #(
    .LocalRID_X            (3),
    .LocalRID_Y            (3)
)router15(
    .clk                   (clk),
    .rstn                  (rstn),
    .west_data_i           (data_14_to_15),
    .west_valid_i          (valid_14_to_15),
    .west_ready_o          (ready_15_to_14),
    .west_data_o           (data_15_to_14),
    .west_valid_o          (valid_15_to_14),
    .west_ready_i          (ready_14_to_15),
    .east_data_i           (64'b0),
    .east_valid_i          (1'b0),
    .east_ready_o          (),
    .east_data_o           (),
    .east_valid_o          (),
    .east_ready_i          (1'b0),
    .north_data_i          (data_11_to_15),
    .north_valid_i         (valid_11_to_15),
    .north_ready_o         (ready_15_to_11),
    .north_data_o          (data_15_to_11),
    .north_valid_o         (valid_15_to_11),
    .north_ready_i         (ready_11_to_15),
    .south_data_i          (64'b0),
    .south_valid_i         (1'b0),
    .south_ready_o         (),
    .south_data_o          (),
    .south_valid_o         (),
    .south_ready_i         (1'b0),
    .local_data_i          (data_i_3_3),
    .local_valid_i         (valid_i_3_3),
    .local_ready_o         (ready_o_3_3),
    .local_data_o          (data_o_3_3),
    .local_valid_o         (valid_o_3_3),
    .local_ready_i         (ready_i_3_3),
    .bound_data_i          (64'b0),
    .bound_valid_i         (1'b0),
    .bound_ready_o         (),
    .bound_data_o          (),
    .bound_valid_o         (),
    .bound_ready_i         (1'b0)
);

endmodule
