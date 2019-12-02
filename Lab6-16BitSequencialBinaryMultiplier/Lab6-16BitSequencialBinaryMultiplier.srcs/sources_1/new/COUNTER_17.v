// Using 18-bit Shift register
// To shift 10000000000000000
// to       00000000000000001
//                          |
//                          v
//                          Done

module COUNTER_17(
    output DONE,
    input  CLEAR,
    input  CLOCK);
        wire [15:0] tmpBit;
        DFF Bit17(.Q(P_OUT[16]),.P(),.D(BIT16),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(1));
        DFF Bit16(.Q(P_OUT[16]),.P(),.D(BIT16),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit15(.Q(P_OUT[15]),.P(),.D(P_IN[15]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit14(.Q(P_OUT[14]),.P(),.D(P_IN[14]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0]));
        DFF Bit13(.Q(P_OUT[13]),.P(),.D(P_IN[13]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit12(.Q(P_OUT[12]),.P(),.D(P_IN[12]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit11(.Q(P_OUT[11]),.P(),.D(P_IN[11]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit10(.Q(P_OUT[10]),.P(),.D(P_IN[10]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit9(.Q(P_OUT[9]),.P(),.D(P_IN[9]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit8(.Q(P_OUT[8]),.P(),.D(P_IN[8]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit7(.Q(P_OUT[7]),.P(),.D(P_IN[7]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit6(.Q(P_OUT[6]),.P(),.D(P_IN[6]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit5(.Q(P_OUT[5]),.P(),.D(P_IN[5]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit(.Q(P_OUT[4]),.P(),.D(P_IN[4]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit3(.Q(P_OUT[3]),.P(),.D(P_IN[3]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit2(.Q(P_OUT[2]),.P(),.D(P_IN[2]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit1(.Q(P_OUT[1]),.P(),.D(P_IN[1]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
        DFF Bit0(.Q(P_OUT[0]),.P(),.D(P_IN[0]),.Clk(CLOCK),.AsynSet(CLEAR),.AsynVal(0));
endmodule