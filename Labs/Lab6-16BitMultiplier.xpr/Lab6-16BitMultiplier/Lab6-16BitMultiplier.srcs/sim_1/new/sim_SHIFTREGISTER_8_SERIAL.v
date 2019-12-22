`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 03:20:50 AM
// Design Name: 
// Module Name: sim_SHIFTREGISTER_8_SERIAL
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


module sim_SHIFTREGISTER_8_SERIAL();
    wire [7:0] MPLICANT;
    reg START;
    reg [7:0] MPLICANTin;
    reg CLOCK;
    reg S_IN;
    wire S_OUT;
    SHIFTREGISTER_8 test(
        .P_OUT(MPLICANT),   // Will go to summer
        .S_OUT(S_OUT),          // Does not need this either          
        .P_IN(MPLICANTin),  
        .S_IN(S_IN),           // This does not matter since it MPLICANT does not shift
        .SHIFT_LOAD(1),     // test SHIFT
        .ASYN(START),       // Asynchronous clear
        .P_IN_INITIAL(MPLICANTin), // START=1 LOAD MPLICANTin
        .CLOCK(CLOCK));          // Why need clock when you never use it?
    integer i;
    initial begin
        START<=0;
        for(i=0;i<255;i=i+1) begin
            #5 START<=(i%2);
            #5 S_IN<=1;
            #5 MPLICANTin=i;
            #5 CLOCK=1;
            #5 MPLICANTin=(i-1);
            #5 CLOCK=0;
            #5 S_IN<=0;
            #5 MPLICANTin=i;
            #5 CLOCK=1;
            #5 MPLICANTin=(i-1);
            #5 CLOCK=0;
        end
    end
endmodule
