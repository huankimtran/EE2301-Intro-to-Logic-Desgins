`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2019 04:30:27 PM
// Design Name: 
// Module Name: StopLight4Way
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


module StopLight4Way(
    input C0,
    input C1,
    input C2,
    output R1,
    output R2,
    output Y1,
    output Y2,
    output G1,
    output G2
    );
    RedLight Red(C0,C1,C2,R1,R2);
    GreenLight Green(C0,C1,C2,G1,G2);
    YellowLight Yellow(C0,C1,C2,Y1,Y2);
endmodule
