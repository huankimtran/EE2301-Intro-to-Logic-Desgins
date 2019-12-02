`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2019 08:59:23 AM
// Design Name: 
// Module Name: showGlitchInlab
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


module showGlitchInlab();
    reg [3:0] clk;
    wire A,B,C,D,F_0_1,F_1_0,F_fixed;
    assign A=clk[3];
    assign B=clk[2];
    assign C=clk[1];
    assign D=clk[0];
    InlabGlitch glitchGenerator(A,B,C,D,F_0_1);
    InlabGlitchOpositeChange glitchGeneratorOpp(A,B,C,D,F_1_0);
    InlabGlitchFixed glitchGeneratorFixed(A,B,C,D,F_fixed);
    integer i;
    initial
    begin
        for(i=0;i<255;i=i+1)
        begin
            #50 clk=4'b1001;
            #50 clk=4'b0001;
        end
    end
endmodule
