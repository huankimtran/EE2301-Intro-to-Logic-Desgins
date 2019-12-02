`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2019 08:28:30 AM
// Design Name: 
// Module Name: DFF
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


module DFF( 
    output reg Q,
    output Qbar,
    input D,
    input Clk,
    input Reset
    );
    assign Qbar = ~Q; 
    always @(posedge Clk) 
    begin 
     if (Reset == 1'b1) //If not at reset 
      Q <= 1'b0;
     else 
      Q <= D;
    end 
endmodule