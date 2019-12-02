`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 04:14:09 PM
// Design Name: 
// Module Name: YelloLight
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


module YellowLight(
    input C0,
    input C1,
    input C2,
    output Y1,
    output Y2
    );
    wire NOT_C2,AND_C0_C1;
    and AND_1(AND_C0_C1,C0,C1);
    not NOT_2(NOT_C2,C2);
    and AND_2(Y2,AND_C0_C1,C2);
    and AND_3(Y1,AND_C0_C1,NOT_C2);
endmodule
