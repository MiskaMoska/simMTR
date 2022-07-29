`include "params.vh"

module mux_ready_6to1(
    input       wire            [5:0]           mux_sel,
    input       wire            [5:0]           ready_in,
    output      reg                             ready_out   
);

always@(*) begin
    case(mux_sel)
        6'b000001:    ready_out = ready_in[0];
        6'b000010:    ready_out = ready_in[1];
        6'b000100:    ready_out = ready_in[2];
        6'b001000:    ready_out = ready_in[3];
        6'b010000:    ready_out = ready_in[4];
        6'b100000:    ready_out = ready_in[5];
        default:    ready_out = 1'b0;
    endcase
end

endmodule