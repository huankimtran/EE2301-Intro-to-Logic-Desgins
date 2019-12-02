`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2019 08:35:16 AM
// Design Name: 
// Module Name: BinaryCounter_4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// output reg Q,
//    output Qbar,
//    input D,
//    input Clk,
//    input Reset
module BinaryCounter_4(
        output [2:0] C,
        input CLK
    );
    wire [2:0] BW;
    DFF DFF0(.Q(C[0]),.Qbar(BW[0]),.D(BW[0]),.Clk(CLK),.Reset(1'b0));
    DFF DFF1(.Q(C[1]),.Qbar(BW[1]),.D(BW[1]),.Clk(BW[0]),.Reset(1'b0));
    DFF DFF2(.Q(C[2]),.Qbar(BW[2]),.D(BW[2]),.Clk(BW[1]),.Reset(1'b0));
endmodule
