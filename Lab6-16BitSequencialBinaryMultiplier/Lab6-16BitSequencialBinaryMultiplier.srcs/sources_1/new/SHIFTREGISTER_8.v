`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 06:17:43 PM
// Design Name: 
// Module Name: SHIFTREGISTER_8
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
//////////////////////////////////////////////////////////////////////////////////
//
//             P_IN[7]  P_IN[15]   .......     P_IN[0]
//               |        |                      |
//               v        v                      v  
//     S_IN -> BIT7 ---- BIT6 . . . . . . . . .BIT0 -> S_OUT
//  
//      SHIFT_LOAD=1 -> Shift S_IN
//      SHIFT_LOAD=0 -> Load P_IN[7]


module SHIFTREGISTER_8(
        output [7:0] P_OUT,
        output S_OUT,
        input [7:0] P_IN,
        input S_IN,
        input SHIFT_LOAD,
        input CLEAR,
        input [7:0] P_INITIAL,
        input CLOCK);
        wire BIT7,BIT0;
        MUX_2_1 SHIFTorLOAD(.Out(BIT7),.S(SHIFT_LOAD),.Op_0(P_IN[7]),.Op_1(S_IN));    // Choose what to put in depends on SHIFT_LOAD
        assign S_OUT=P_OUT[0];   // S_OUT is always the lsb 
         // AsynVal=0 to make all bits set to 0 when CLEAR=1 
        DFF Bit7(.Q(P_OUT[7]),.P(),.D(BIT7),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[7]));
        DFF Bit6(.Q(P_OUT[6]),.P(),.D(P_IN[6]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[6]));
        DFF Bit5(.Q(P_OUT[5]),.P(),.D(P_IN[5]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[5]));
        DFF Bit(.Q(P_OUT[4]),.P(),.D(P_IN[4]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[4]));
        DFF Bit3(.Q(P_OUT[3]),.P(),.D(P_IN[3]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[3]));
        DFF Bit2(.Q(P_OUT[2]),.P(),.D(P_IN[2]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[2]));
        DFF Bit1(.Q(P_OUT[1]),.P(),.D(P_IN[1]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[1]));
        DFF Bit0(.Q(P_OUT[0]),.P(),.D(P_IN[0]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[0]));
endmodule

