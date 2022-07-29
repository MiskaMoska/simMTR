`include "params.vh"

module input_stage #(
    parameter   LocalRID_X = 4'b0,
    parameter   LocalRID_Y = 4'b0
)(
    input       wire                            clk,
    input       wire                            rstn,    

    input       wire                            valid_i,
    input       wire        [`DW-1:0]           data_i,
    output      wire                            ready_o,

    output      wire        [`CN-1:0]           reqVC,
    input       wire        [`CN-1:0]           selOutVC,
    input       wire                            VCgranted,
    output      wire        [`CN-1:0]           selXBVC,

    output      wire                            valid_o,
    output      wire        [`DW-1:0]           data_o,
    input       wire                            ready_i
);

wire            fifo_read,fifo_write;
wire            fifo_empty,fifo_full;
wire [`DW-1:0]  fifo_din,fifo_dout;
wire [`CN-1:0]  candidateOutVC;

wire fire;
assign fire = valid_o & ready_i;
assign valid_o = ~fifo_empty;
assign data_o = fifo_dout;
assign fifo_din = data_i;

assign fifo_read = fire;
assign fifo_write = valid_i & ready_o;
assign ready_o = ~fifo_full;

SyncFIFO_RTL #(
    .width                   (`DW),
    .depth                   (`FIFO_DEPTH),
    .depth_LOG               (`FIFO_DEPTH_LOG),
    .FWFT                    (1)
)fifo(
    .clk_i                   (clk),
    .rst_i                   (~rstn),
    .read_i                  (fifo_read),
    .write_i                 (fifo_write),
    .full_o                  (fifo_full),
    .empty_o                 (fifo_empty),
    .data_i                  (fifo_din),
    .data_o                  (fifo_dout)
);

route_calculator #(
    .LocalRID_X              (LocalRID_X),
    .LocalRID_Y              (LocalRID_Y)
)rc(
    .clk                     (clk),
    .rstn                    (rstn),
    .drid_x                  (fifo_dout[`RTDRID_X_H:`RTDRID_X_L]),
    .drid_y                  (fifo_dout[`RTDRID_Y_H:`RTDRID_Y_L]),
    .outbound                (fifo_dout[`OUTBOUND_M]),
    .candidateOutVC          (candidateOutVC)
);

input_controller ctlr(
    .clk                     (clk),
    .rstn                    (rstn),
    .fifo_empty              (fifo_empty),
    .candidateOutVC          (candidateOutVC),
    .reqVC                   (reqVC),
    .selOutVC                (selOutVC),
    .VCgranted               (VCgranted),
    .selXBVC                 (selXBVC),
    .flit_type               (fifo_dout[`DW-1:`DW-2]),
    .flit_fire               (fire)
);

endmodule