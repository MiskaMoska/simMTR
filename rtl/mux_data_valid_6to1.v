`include "params.vh"

module mux_data_valid_6to1(
    input       wire            [5:0]           mux_sel,
    input       wire            [`DW-1:0]       data_in_vc0,
    input       wire            [`DW-1:0]       data_in_vc1,
    input       wire            [`DW-1:0]       data_in_vc2,
    input       wire            [`DW-1:0]       data_in_vc3,
    input       wire            [`DW-1:0]       data_in_vc4,
    input       wire            [`DW-1:0]       data_in_vc5,
    input       wire            [5:0]           valid_in,
    output      reg             [`DW-1:0]       data_out,
    output      reg                             valid_out   
);

always@(*) begin
    case(mux_sel)
        6'b000001:    data_out = data_in_vc0;
        6'b000010:    data_out = data_in_vc1;
        6'b000100:    data_out = data_in_vc2;
        6'b001000:    data_out = data_in_vc3;
        6'b010000:    data_out = data_in_vc4;
        6'b100000:    data_out = data_in_vc5;
        default:      data_out = 0;
    endcase
end

always@(*) begin
    case(mux_sel)
        6'b000001:    valid_out = valid_in[0];
        6'b000010:    valid_out = valid_in[1];
        6'b000100:    valid_out = valid_in[2];
        6'b001000:    valid_out = valid_in[3];
        6'b010000:    valid_out = valid_in[4];
        6'b100000:    valid_out = valid_in[5];
        default:      valid_out = 0;
    endcase
end

endmodule