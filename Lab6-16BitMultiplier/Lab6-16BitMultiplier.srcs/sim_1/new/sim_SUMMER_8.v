`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 04:13:01 AM
// Design Name: 
// Module Name: sim_SUMMER_8
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


module sim_SUMMER_8();
wire Cout;
wire [3:0] OUT;
SUMMER_8 sum(
    .OUT(OUT),
    .Cout(Cout),
    .A(8'b10000111),
    .B(8'd1),
    .Cin(1));
endmodule
