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
    reg START;
    reg CLOCK;
    reg MPLICANTin;
    reg MULPLIERin;
    COUNTER_17 c(
        .DONE(DONE),
        .CLEAR(START),
        .CLOCK(CLOCK));
    integer i;
    initial begin
        #5 CLOCK=1;
        #5 CLOCK=0;
        START<=1;
        MPLICANTin<=8'd11111111;
        MULPLIERin<=8'b11111110;
        #5 CLOCK=1;
        #5 CLOCK=0;
        #5 CLOCK=1;
        #5 CLOCK=0;
        START<=0;
        for(i=0;i<18;i=i+1) begin
            #5 CLOCK=1;
            #5 CLOCK=0;
        end
    end
endmodule
