`include "params.vh"

module crossbar(
    //select signals from input ports
    input       wire            [5:0]           selVCfromVC0,
    input       wire            [5:0]           selVCfromVC1,
    input       wire            [5:0]           selVCfromVC2,
    input       wire            [5:0]           selVCfromVC3,
    input       wire            [5:0]           selVCfromVC4,
    input       wire            [5:0]           selVCfromVC5,

    //data from 5 input ports 
    input       wire            [`DW-1:0]       data_in_vc0,
    input       wire            [`DW-1:0]       data_in_vc1,
    input       wire            [`DW-1:0]       data_in_vc2,
    input       wire            [`DW-1:0]       data_in_vc3,
    input       wire            [`DW-1:0]       data_in_vc4,
    input       wire            [`DW-1:0]       data_in_vc5,

    //data to 5 output ports 
    output      wire            [`DW-1:0]       data_out_vc0,
    output      wire            [`DW-1:0]       data_out_vc1,
    output      wire            [`DW-1:0]       data_out_vc2,
    output      wire            [`DW-1:0]       data_out_vc3,
    output      wire            [`DW-1:0]       data_out_vc4,
    output      wire            [`DW-1:0]       data_out_vc5,

    //valid from 5 input ports
    input       wire            [5:0]           valid_in,

    //valid to 5 output ports
    output      wire            [5:0]           valid_out,

    //ready from 5 output ports
    input       wire            [5:0]           ready_in,

    //ready to 5 input ports
    output      wire            [5:0]           ready_out
);

//sel signals at output port
wire [5:0] mux_sel_vc0; 
wire [5:0] mux_sel_vc1;
wire [5:0] mux_sel_vc2;
wire [5:0] mux_sel_vc3;
wire [5:0] mux_sel_vc4;
wire [5:0] mux_sel_vc5;

assign mux_sel_vc0 = {selVCfromVC5[0],selVCfromVC4[0],selVCfromVC3[0],selVCfromVC2[0],selVCfromVC1[0],selVCfromVC0[0]};
assign mux_sel_vc1 = {selVCfromVC5[1],selVCfromVC4[1],selVCfromVC3[1],selVCfromVC2[1],selVCfromVC1[1],selVCfromVC0[1]};
assign mux_sel_vc2 = {selVCfromVC5[2],selVCfromVC4[2],selVCfromVC3[2],selVCfromVC2[2],selVCfromVC1[2],selVCfromVC0[2]};
assign mux_sel_vc3 = {selVCfromVC5[3],selVCfromVC4[3],selVCfromVC3[3],selVCfromVC2[3],selVCfromVC1[3],selVCfromVC0[3]};
assign mux_sel_vc4 = {selVCfromVC5[4],selVCfromVC4[4],selVCfromVC3[4],selVCfromVC2[4],selVCfromVC1[4],selVCfromVC0[4]};
assign mux_sel_vc5 = {selVCfromVC5[5],selVCfromVC4[5],selVCfromVC3[5],selVCfromVC2[5],selVCfromVC1[5],selVCfromVC0[5]};

mux_data_valid_6to1 mux_data_valid_to_output_vc0(
    .mux_sel                   (mux_sel_vc0),
    .data_in_vc0               (data_in_vc0),
    .data_in_vc1               (data_in_vc1),
    .data_in_vc2               (data_in_vc2),
    .data_in_vc3               (data_in_vc3),
    .data_in_vc4               (data_in_vc4),
    .data_in_vc5               (data_in_vc5),
    .valid_in                  (valid_in),
    .data_out                  (data_out_vc0),
    .valid_out                 (valid_out[0])
);

mux_data_valid_6to1 mux_data_valid_to_output_vc1(
    .mux_sel                   (mux_sel_vc1),
    .data_in_vc0               (data_in_vc0),
    .data_in_vc1               (data_in_vc1),
    .data_in_vc2               (data_in_vc2),
    .data_in_vc3               (data_in_vc3),
    .data_in_vc4               (data_in_vc4),
    .data_in_vc5               (data_in_vc5),
    .valid_in                  (valid_in),
    .data_out                  (data_out_vc1),
    .valid_out                 (valid_out[1])
);

mux_data_valid_6to1 mux_data_valid_to_output_vc2(
    .mux_sel                   (mux_sel_vc2),
    .data_in_vc0               (data_in_vc0),
    .data_in_vc1               (data_in_vc1),
    .data_in_vc2               (data_in_vc2),
    .data_in_vc3               (data_in_vc3),
    .data_in_vc4               (data_in_vc4),
    .data_in_vc5               (data_in_vc5),
    .valid_in                  (valid_in),
    .data_out                  (data_out_vc2),
    .valid_out                 (valid_out[2])
);

mux_data_valid_6to1 mux_data_valid_to_output_vc3(
    .mux_sel                   (mux_sel_vc3),
    .data_in_vc0               (data_in_vc0),
    .data_in_vc1               (data_in_vc1),
    .data_in_vc2               (data_in_vc2),
    .data_in_vc3               (data_in_vc3),
    .data_in_vc4               (data_in_vc4),
    .data_in_vc5               (data_in_vc5),
    .valid_in                  (valid_in),
    .data_out                  (data_out_vc3),
    .valid_out                 (valid_out[3])
);

mux_data_valid_6to1 mux_data_valid_to_output_vc4(
    .mux_sel                   (mux_sel_vc4),
    .data_in_vc0               (data_in_vc0),
    .data_in_vc1               (data_in_vc1),
    .data_in_vc2               (data_in_vc2),
    .data_in_vc3               (data_in_vc3),
    .data_in_vc4               (data_in_vc4),
    .data_in_vc5               (data_in_vc5),
    .valid_in                  (valid_in),
    .data_out                  (data_out_vc4),
    .valid_out                 (valid_out[4])
);

mux_data_valid_6to1 mux_data_valid_to_output_vc5(
    .mux_sel                   (mux_sel_vc5),
    .data_in_vc0               (data_in_vc0),
    .data_in_vc1               (data_in_vc1),
    .data_in_vc2               (data_in_vc2),
    .data_in_vc3               (data_in_vc3),
    .data_in_vc4               (data_in_vc4),
    .data_in_vc5               (data_in_vc5),
    .valid_in                  (valid_in),
    .data_out                  (data_out_vc5),
    .valid_out                 (valid_out[5])
);


mux_ready_6to1 mux_ready_to_input_vc0(
    .mux_sel                 (selVCfromVC0),
    .ready_in                (ready_in),
    .ready_out               (ready_out[0])
);

mux_ready_6to1 mux_ready_to_input_vc1(
    .mux_sel                 (selVCfromVC1),
    .ready_in                (ready_in),
    .ready_out               (ready_out[1])
);

mux_ready_6to1 mux_ready_to_input_vc2(
    .mux_sel                 (selVCfromVC2),
    .ready_in                (ready_in),
    .ready_out               (ready_out[2])
);

mux_ready_6to1 mux_ready_to_input_vc3(
    .mux_sel                 (selVCfromVC3),
    .ready_in                (ready_in),
    .ready_out               (ready_out[3])
);

mux_ready_6to1 mux_ready_to_input_vc4(
    .mux_sel                 (selVCfromVC4),
    .ready_in                (ready_in),
    .ready_out               (ready_out[4])      
);

mux_ready_6to1 mux_ready_to_input_vc5(
    .mux_sel                 (selVCfromVC5),
    .ready_in                (ready_in),
    .ready_out               (ready_out[5])
);
endmodule