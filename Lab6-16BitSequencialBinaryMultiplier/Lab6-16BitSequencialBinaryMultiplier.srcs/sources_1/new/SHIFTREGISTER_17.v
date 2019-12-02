`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2019 02:25:45 PM
// Design Name: 
// Module Name: SHIFTREGISTER_17
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
//
//             P_IN[16] P_IN[15]   .......     P_IN[0]
//               |        |                      |
//               v        v                      v  
//     S_IN -> BIT16 -- BIT15 . . . . . . . . .BIT0 -> S_OUT
//  
//      SHIFT_LOAD=1 -> Shift S_IN
//      SHIFT_LOAD=0 -> Load P_IN[16]
//
// When CLEAR = 1, What ever in P_INITIAL will be loaded in 


module SHIFTREGISTER_17(
        output [16:0] P_OUT,
        output S_OUT,
        input [16:0] P_IN,
        input S_IN,
        input SHIFT_LOAD,
        input CLEAR,
        input [16:0] P_INITIAL,
        input CLOCK);
        wire BIT16,BIT0;
        MUX_2_1 SHIFTorLOAD(.Out(BIT16),.S(SHIFT_LOAD),.Op_0(P_IN[16]),.Op_1(S_IN));    // Choose what to put in depends on SHIFT_LOAD
        assign S_OUT=P_OUT[0];   // S_OUT is always the lsb 
        DFF Bit16(.Q(P_OUT[16]),.P(),.D(BIT16),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[16]));
        DFF Bit15(.Q(P_OUT[15]),.P(),.D(P_IN[15]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[15]));
        DFF Bit14(.Q(P_OUT[14]),.P(),.D(P_IN[14]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[14]));
        DFF Bit13(.Q(P_OUT[13]),.P(),.D(P_IN[13]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[13]));
        DFF Bit12(.Q(P_OUT[12]),.P(),.D(P_IN[12]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[12]));
        DFF Bit11(.Q(P_OUT[11]),.P(),.D(P_IN[11]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[11]));
        DFF Bit10(.Q(P_OUT[10]),.P(),.D(P_IN[10]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[10]));
        DFF Bit9(.Q(P_OUT[9]),.P(),.D(P_IN[9]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[9]));
        DFF Bit8(.Q(P_OUT[8]),.P(),.D(P_IN[8]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[8]));
        DFF Bit7(.Q(P_OUT[7]),.P(),.D(P_IN[7]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[7]));
        DFF Bit6(.Q(P_OUT[6]),.P(),.D(P_IN[6]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[6]));
        DFF Bit5(.Q(P_OUT[5]),.P(),.D(P_IN[5]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[5]));
        DFF Bit(.Q(P_OUT[4]),.P(),.D(P_IN[4]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[4]));
        DFF Bit3(.Q(P_OUT[3]),.P(),.D(P_IN[3]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[3]));
        DFF Bit2(.Q(P_OUT[2]),.P(),.D(P_IN[2]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[2]));
        DFF Bit1(.Q(P_OUT[1]),.P(),.D(P_IN[1]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[1]));
        DFF Bit0(.Q(P_OUT[0]),.P(),.D(P_IN[0]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(P_INITIAL[0]));
endmodule
