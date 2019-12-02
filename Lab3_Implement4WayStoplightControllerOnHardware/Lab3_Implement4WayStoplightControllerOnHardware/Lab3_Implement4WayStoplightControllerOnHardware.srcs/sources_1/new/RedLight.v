`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 04:14:09 PM
// Design Name: 
// Module Name: RedLight
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


module RedLight(
    input C0,
    input C1,
    input C2,
    output R1,
    output R2
    );
    wire AND_NOTC1_NOTC0,NOT_C1,NOT_C0,NOT_C2;
    not NOT_1(NOT_C1,C1);
    not NOT_2(NOT_C0,C0);
    not NOT_3(NOT_C2,C2);
    and AND_1(AND_NOTC1_NOTC0,NOT_C1,NOT_C0);
    or OR_1(R1,C2,AND_NOTC1_NOTC0);
    or OR_2(R2,NOT_C2,AND_NOTC1_NOTC0);
    
endmodule
