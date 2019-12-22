`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 08:35:10 AM
// Design Name: 
// Module Name: prelabGlitchFixedSim
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


module prelabGlitchFixedSim();
    reg [2:0] clk;
    wire A;
    wire B;
    wire C;
    wire F;
    
    assign A=clk[0];
    assign B=clk[1];
    assign C=clk[2];
    
    prelabGlitchFixed glitchGenerator(A,B,C,F);
    integer i;
    initial
    begin
        for(i = 0; i < 10;i=i+1)
        begin
            #50 clk=3'b111;
            #50 clk=3'b101;
        end
    end
endmodule
