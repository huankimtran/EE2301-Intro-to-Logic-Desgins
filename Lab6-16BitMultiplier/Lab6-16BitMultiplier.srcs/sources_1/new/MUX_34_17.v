`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 12:40:55 AM
// Design Name: 
// Module Name: MUX_34_17
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


module MUX_34_17(
    output [16:0] OUT,
    input S,
    input [16:0] OPT0,
    input [16:0] OPT1);
    assign OUT=({17{!S}}&OPT0)^({17{S}}&OPT1);
endmodule