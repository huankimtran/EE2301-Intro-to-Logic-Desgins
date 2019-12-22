`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/02/2019 09:41:39 AM
// Design Name: 
// Module Name: sim_MULTIPLIER_16_internal
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


module sim_MULTIPLIER_16_internal();
    wire [15:0] PRODUCT;
    reg [7:0] MPLICANTin;
    reg   [7:0] MULPLIERin;
    reg   START;
    reg   CLOCK;
    wire [7:0] accu_out;
    wire [7:0] summer_out;
    wire [7:0] accu_in;
    wire [7:0] MplicantORnot;
//    wire [7:0] MPLICANT;
//    wire [7:0] MULPLIER;
    wire S_MplicantORnot;
    wire CLOCK_OR_NOT;
    wire DONE;
    wire Sum8Cout;
//    SHIFTREGISTER_8 MPLICANTREG(
//        .P_OUT(MPLICANT),   // Will go to summer
//        .S_OUT(),          // Does not need this either          
//        .P_IN(MPLICANTin),  
//        .S_IN(0),           // This does not matter since it MPLICANT does not shift
//        .SHIFT_LOAD(0),     // Accu does not need to shift
//        .CLOCK(1));          // Why need clock when you never use it?
//    SHIFTREGISTER_8 MULPLIERREG(
//        .P_OUT(MULPLIER),   // Will go to summer
//        .S_OUT(),          // Does not need this either          
//        .P_IN(MULPLIERin),  
//        .S_IN(0),           // This does not matter since it MPLICANT does not shift
//        .SHIFT_LOAD(0),     // does not need to shift
//        .CLOCK(1));          // Why need clock when you never use it?
    MUX_16_8 muxMplicantORnot(
        .OUT(MplicantORnot),
        .S(S_MplicantORnot),
        .OPT0(8'b0000000),
        .OPT1(MPLICANTin));
    MUX_16_8 loadAccu(
        .OUT(accu_in),
        .S(START),
        .OPT0({Sum8Cout,summer_out[7:1]}),
        .OPT1(8'b0000000));   
    SHIFTREGISTER_8 ACCU(
        .P_OUT(accu_out),   // Will go to summer
        .S_OUT(),          // Does not need this either          
        .P_IN(accu_in),  // Take in from output of summer 
        .S_IN(0),           // This does not matter since it Accu does not shift
        .SHIFT_LOAD(0),     // Accu does not need to shift
        .CLOCK(CLOCK_OR_NOT));
    SUMMER_8 sum8(
        .OUT(summer_out),
        .Cout(Sum8Cout),
        .A(accu_out),
        .B(MplicantORnot),
        .Cin(0));       // Does not need Cin
    MUX_2_1 muxClock(
        .OUT(CLOCK_OR_NOT),
        .S(DONE),
        .OPT1(0),   // No Clock when DONE=1
        .OPT0(CLOCK));
    COUNTER_17 counter(
        .DONE(DONE),
        .CLEAR(START),
        .CLOCK(CLOCK));
    SHIFTREGISTER_17 PRODUCT_REG(
        .P_OUT(PRODUCT),   // TODO- 17 to 16 bit still correct?
        .S_OUT(S_MplicantORnot),          // Does not need this either          
        .P_IN({9'b0,MULPLIERin}),                
        .S_IN(summer_out[0]),
        .SHIFT_LOAD(!START),     // load when START=1, otherwise SHIFT
        .CLOCK(CLOCK_OR_NOT));    
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
