//to connect the target NoC and the interposer NoC
//the target-to-interposer link is responsible to:
//  1.  clear the outbound bit 
//  2.  replace the RTDRID with ITPDRID
//the interposer-to-target link is responsible to:
//  1.  replace the RTDRID with DRID

`include "params.vh"

module bound_link(
    input       wire                            clk,
    input       wire                            rstn,

    //link at the target NoC side
    input       wire        [`DW-1:0]           trg_data_i,  
    input       wire                            trg_valid_i,
    output      wire                            trg_ready_o,

    output      wire        [`DW-1:0]           trg_data_o,
    output      wire                            trg_valid_o,
    input       wire                            trg_ready_i,

    //link at the interposer NoC side
    input       wire        [`DW-1:0]           itp_data_i,  
    input       wire                            itp_valid_i,
    output      wire                            itp_ready_o,

    output      wire        [`DW-1:0]           itp_data_o,
    output      wire                            itp_valid_o,
    input       wire                            itp_ready_i
);

/******************************** target to interposer logic **********************************/
wire    [`DW-1:0]   fifo_trg2itp_din;
wire    fifo_trg2itp_empty,fifo_trg2itp_full;

assign fifo_trg2itp_din[`DW-1:`OUTBOUND_M+1] = trg_data_i[`DW-1:`OUTBOUND_M+1];
assign fifo_trg2itp_din[`OUTBOUND_M] = trg_data_i[`DW-1:`DW-2] == `HEAD ? 1'b0 : trg_data_i[`OUTBOUND_M];
assign fifo_trg2itp_din[`OUTBOUND_M-1:`RTDRID_X_H+1] = trg_data_i[`OUTBOUND_M-1:`RTDRID_X_H+1];
assign fifo_trg2itp_din[`RTDRID_X_H:`RTDRID_Y_L] = trg_data_i[`DW-1:`DW-2] == `HEAD ? trg_data_i[`ITPDRID_X_H:`ITPDRID_Y_L] :
                                                                                        trg_data_i[`RTDRID_X_H:`RTDRID_Y_L];

assign trg_ready_o = ~fifo_trg2itp_full;
assign itp_valid_o = ~fifo_trg2itp_empty;

SyncFIFO_RTL #(
    .width                   (`DW),
    .depth                   (`BFIFO_DEPTH),
    .depth_LOG               (`BFIFO_DEPTH_LOG),
    .FWFT                    (1)
)fifo_trg2itp(
    .clk_i                   (clk),
    .rst_i                   (~rstn),
    .read_i                  (itp_valid_o & itp_ready_i),
    .write_i                 (trg_valid_i & trg_ready_o),
    .full_o                  (fifo_trg2itp_full),
    .empty_o                 (fifo_trg2itp_empty),
    .data_i                  (fifo_trg2itp_din),
    .data_o                  (itp_data_o)
);

/******************************** interposer to traget logic **********************************/
wire    [`DW-1:0]   fifo_itp2trg_din;
wire    fifo_itp2trg_empty,fifo_itp2trg_full;

assign fifo_itp2trg_din[`DW-1:`RTDRID_X_H+1] = itp_data_i[`DW-1:`RTDRID_X_H+1];
assign fifo_itp2trg_din[`RTDRID_X_H:`RTDRID_Y_L] = itp_data_i[`DW-1:`DW-2] == `HEAD ? itp_data_i[`DRID_X_H:`DRID_Y_L] :
                                                                                        itp_data_i[`RTDRID_X_H:`RTDRID_Y_L];
assign itp_ready_o = ~fifo_itp2trg_full;
assign trg_valid_o = ~fifo_itp2trg_empty;

SyncFIFO_RTL #(
    .width                   (`DW),
    .depth                   (`BFIFO_DEPTH),
    .depth_LOG               (`BFIFO_DEPTH_LOG),
    .FWFT                    (1)
)fifo_itp2trg(
    .clk_i                   (clk),
    .rst_i                   (~rstn),
    .read_i                  (trg_valid_o & trg_ready_i),
    .write_i                 (itp_valid_i & itp_ready_o),
    .full_o                  (fifo_itp2trg_full),
    .empty_o                 (fifo_itp2trg_empty),
    .data_i                  (fifo_itp2trg_din),
    .data_o                  (trg_data_o)
);
endmodule