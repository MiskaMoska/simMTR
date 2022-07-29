`include "params.vh"

module route_calculator #(
    parameter   LocalRID_X = 4'b0,
    parameter   LocalRID_Y = 4'b0
)(  
    input       wire                            clk,
    input       wire                            rstn,
    input       wire        [3:0]               drid_x, //from input buffer out
    input       wire        [3:0]               drid_y, //from input buffer out
    input       wire                            outbound, //from input buffer out
    output      reg         [`CN-1:0]           candidateOutVC  //to input controller
);

always@(*) begin
    if(drid_x != LocalRID_X) begin
        if(drid_x < LocalRID_X) candidateOutVC = 6'b000010; //west
        else candidateOutVC = 6'b001000; //east
    end else if(drid_y != LocalRID_Y) begin
        if(drid_y < LocalRID_Y) candidateOutVC = 6'b000001; //north
        else candidateOutVC = 6'b000100; //south
    end else begin
        if(outbound) candidateOutVC = 6'b100000; //bound
        else candidateOutVC = 6'b010000; //local
    end
end
endmodule