`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2019 09:17:28 AM
// Design Name: 
// Module Name: BinaryCounter_4_SIM
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


module BinaryCounter_4_SIM();
    wire [3:0] C;
    reg CLK;
    reg RST;
    wire [3:0] BW;
    DFF DFF0(.Q(C[0]),.Qbar(BW[0]),.D(BW[0]),.Clk(CLK),.Reset(RST));
    DFF DFF1(.Q(C[1]),.Qbar(BW[1]),.D(BW[1]),.Clk(BW[0]),.Reset(RST));
    DFF DFF2(.Q(C[2]),.Qbar(BW[2]),.D(BW[2]),.Clk(BW[1]),.Reset(RST));
    DFF DFF3(.Q(C[3]),.Qbar(BW[3]),.D(BW[3]),.Clk(BW[2]),.Reset(RST));
    
    integer i=0;
    initial 
    begin
    CLK=1'b0;
    RST=1'b1;
    #20 CLK=~CLK;
    #20 CLK=~CLK;
    RST=1'b0;
    for(i=0;i<1024;i=i+1)
        begin
        #20 CLK=~CLK;
        end
    end
endmodule
