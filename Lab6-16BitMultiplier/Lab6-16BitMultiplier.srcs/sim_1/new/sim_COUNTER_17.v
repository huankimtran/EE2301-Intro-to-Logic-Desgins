`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 03:42:28 AM
// Design Name: 
// Module Name: sim_COUNTER_17
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


module sim_COUNTER_17();
    wire DONE;
    reg CLEAR;
    reg CLOCK;
    COUNTER_17 c(
        .DONE(DONE),
        .CLEAR(CLEAR),
        .CLOCK(CLOCK));
    integer i;
    initial begin
        CLEAR<=1;
        for(i=0;i<18;i=i+1) begin
            #5 CLOCK=1;
            #5 CLOCK=0;
        end
    end
endmodule
