module MULTIPLIER_16(
    output [15:0] PRODUCT,
    input  [7:0] MPLICANTin,
    input  [7:0] MULPLIERin,
    input   START,
    input   CLOCK);
    wire [7:0] accu_out;
    wire [7:0] summer_out;
    wire [7:0] accu_in;
    wire [7:0] MplicantORnot;
    wire [7:0] MPLICANT;
    wire [7:0] MULPLIER;
    wire S_MplicantORnot;
    wire CLOCK_OR_NOT;
    wire DONE;
    SHIFTREGISTER_8 MPLICANTREG(
        .P_OUT(MPLICANT),   // Will go to summer
        .S_OUT(),          // Does not need this either          
        .P_IN(MPLICANTin),  
        .S_IN(0),           // This does not matter since it MPLICANT does not shift
        .SHIFT_LOAD(0),     // Accu does not need to shift
        .ASYN(START),       // Asynchronous clear
        .P_IN_INITIAL(MPLICANTin), // START=1 LOAD MPLICANTin
        .CLOCK(1));          // Why need clock when you never use it?
    SHIFTREGISTER_8 MULPLIERREG(
        .P_OUT(MULPLIER),   // Will go to summer
        .S_OUT(),          // Does not need this either          
        .P_IN(MULPLIERin),  
        .S_IN(0),           // This does not matter since it MPLICANT does not shift
        .SHIFT_LOAD(0),     // does not need to shift
        .ASYN(START),       // START=1 LOAD MULPLIERin
        .P_IN_INITIAL(MULPLIERin), // Clear to MULPLIERin
        .CLOCK(1));          // Why need clock when you never use it?
    MUX_16_8 muxMplicantORnot(
        .OUT(MplicantORnot),
        .S(S_MplicantORnot),
        .OPT0(8'b0000000),
        .OPT1(MPLICANT));
    SHIFTREGISTER_8 ACCU(
        .P_OUT(accu_out),   // Will go to summer
        .S_OUT(),          // Does not need this either          
        .P_IN(accu_in),  // Take in from output of summer 
        .S_IN(0),           // This does not matter since it Accu does not load
        .SHIFT_LOAD(0),     // Accu does not need to shift
        .ASYN(START),       // Asynchronous clear
        .P_IN_INITIAL(8'b00000000), // Clear to 0
        .CLOCK(CLOCK_OR_NOT));
    assign accu_in[6:0]=summer_out[7:1];    // new value to put into accu
    SUMMER_8 sum8(
        .OUT(summer_out),
        .Cout(accu_in[7]),
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
        .CLOCK(CLOCK_OR_NOT));
    SHIFTREGISTER_17 PRODUCT_REG(
        .P_OUT(PRODUCT),   // TODO- 17 to 16 bit still correct?
        .S_OUT(S_MplicantORnot),          // Does not need this either          
        .P_IN(),                // Does not need since ony shift 
        .S_IN(summer_out[0]),
        .SHIFT_LOAD(1),     // only shift
        .ASYN(START),       // Asynchronous Load
        .P_IN_INITIAL({9'b000000000,MULPLIER}), // Clear to 0
        .CLOCK(CLOCK_OR_NOT));            
    //TODO-ADd clock source to clock
endmodule