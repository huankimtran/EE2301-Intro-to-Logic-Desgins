`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 03:59:08 AM
// Design Name: 
// Module Name: sim_MULTIPLIER_16
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


module sim_MULTIPLIER_16();
wire [15:0] PRODUCT;
reg CLOCK;
reg START;
reg [7:0] MPLICANTin;
reg [7:0] MULPLIERin; 
MULTIPLIER_16 test(
    .PRODUCT(PRODUCT),
    .MPLICANTin(MPLICANTin),
    .MULPLIERin(MULPLIERin),
    .START(START),
    .CLOCK(CLOCK));
    
    integer i;
    initial begin
        #5 CLOCK=1;
        #5 CLOCK=0;
        START<=1;
        MPLICANTin<=8'h00;
        MULPLIERin<=8'hAE;
        #5 CLOCK=1;
        #5 CLOCK=0;
        START<=0;
        for(i=0;i<17;i=i+1) begin
            #5 CLOCK=1;
            #5 CLOCK=0;
        end
        #50 CLOCK=1;
        #5 CLOCK=0;
        START<=1;
        MPLICANTin<=8'h01;
        MULPLIERin<=8'hAE;
        #5 CLOCK=1;
        #5 CLOCK=0;
        START<=0;
        for(i=0;i<17;i=i+1) begin
            #5 CLOCK=1;
            #5 CLOCK=0;
        end
        #50 CLOCK=1;
        #5 CLOCK=0;
        START<=1;
        MPLICANTin<=8'hAE;
        MULPLIERin<=8'h01;
        #5 CLOCK=1;
        #5 CLOCK=0;
        START<=0;
        for(i=0;i<17;i=i+1) begin
            #5 CLOCK=1;
            #5 CLOCK=0;
        end
        #50 CLOCK=1;
        #5 CLOCK=0;
        START<=1;
        MPLICANTin<=8'd11111111;
        MULPLIERin<=8'b11111110;
        #5 CLOCK=1;
        #5 CLOCK=0;
        START<=0;
        for(i=0;i<17;i=i+1) begin
            #5 CLOCK=1;
            #5 CLOCK=0;
        end
        #50 CLOCK=1;
    end
endmodule
