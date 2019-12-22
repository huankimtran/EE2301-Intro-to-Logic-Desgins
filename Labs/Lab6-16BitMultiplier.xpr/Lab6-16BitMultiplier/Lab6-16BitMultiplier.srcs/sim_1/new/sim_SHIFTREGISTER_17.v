`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 09:48:58 AM
// Design Name: 
// Module Name: sim_SHIFTREGISTER_17
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


module sim_SHIFTREGISTER_17();
    wire [16:0] MPLICANT;
    reg START;
    reg [16:0] MPLICANTin;
    reg CLOCK;
    SHIFTREGISTER_17 test(
        .P_OUT(MPLICANT),   // Will go to summer
        .S_OUT(),          // Does not need this either          
        .P_IN(MPLICANTin),  
        .S_IN(0),           // This does not matter since it MPLICANT does not shift
        .SHIFT_LOAD(0),     // Accu does not need to shift
        .CLOCK(CLOCK));          // Why need clock when you never use it?
    integer i;
    initial begin
        for(i=0;i<255;i=i+1) begin
            #5 START<=(i%2);
            #5 MPLICANTin=i;
            #5 CLOCK=1;
            #5 MPLICANTin=(i-1);
            #5 CLOCK=0;
        end
    end
endmodule
