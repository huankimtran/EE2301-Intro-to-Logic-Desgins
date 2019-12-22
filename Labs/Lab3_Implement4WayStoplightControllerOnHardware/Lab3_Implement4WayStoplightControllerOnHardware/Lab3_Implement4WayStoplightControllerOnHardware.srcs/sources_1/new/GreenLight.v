`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 04:14:09 PM
// Design Name: 
// Module Name: GreenLight
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


module GreenLight(
    input C0,
    input C1,
    input C2,
    output G1,
    output G2
    );
    wire X,Y;
    xor XOR_1(X,C0,C1);
    and AND_1(G2,X,C2);
    not NOT_1(Y,C2);
    and AND_2(G1,X,Y); 
endmodule
