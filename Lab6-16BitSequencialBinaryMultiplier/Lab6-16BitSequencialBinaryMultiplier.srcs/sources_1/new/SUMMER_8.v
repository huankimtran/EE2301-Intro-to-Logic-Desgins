// SUMMER that can sum two 8-bit numbers
module SUMMER_8(
        output [7:0] Out,
        output Cout,
        input [7:0] A,
        input [7:0] B,
        input Cin);
        wire [6:0] tmpCout;
        FULLADDER Bit0(.Sum(Out[0])
            ,.Cout(tmpCout[0])
            ,.A(A[0])
            ,.B(B[0])
            ,.Cin(Cin));
        
        FULLADDER Bit1(.Sum(Out[1])
            ,.Cout(tmpCout[1])
            ,.A(A[1])
            ,.B(B[1])
            ,.Cin(tmpCout[0]));

        
        FULLADDER Bit2(.Sum(Out[2])
            ,.Cout(tmpCout[2])
            ,.A(A[2])
            ,.B(B[2])
            ,.Cin(tmpCout[1]));

        
        FULLADDER Bit3(.Sum(Out[3])
            ,.Cout(tmpCout[3])
            ,.A(A[3])
            ,.B(B[3])
            ,.Cin(tmpCout[2]));

        
        FULLADDER Bit4(.Sum(Out[4])
            ,.Cout(tmpCout[4])
            ,.A(A[4])
            ,.B(B[4])
            ,.Cin(tmpCout[3]));

        
        FULLADDER Bit5(.Sum(Out[5])
            ,.Cout(tmpCout[5])
            ,.A(A[5])
            ,.B(B[5])
            ,.Cin(tmpCout[4]));

        
        FULLADDER Bit6(.Sum(Out[6])
            ,.Cout(tmpCout[6])
            ,.A(A[6])
            ,.B(B[6])
            ,.Cin(tmpCout[5]));

        
        FULLADDER Bit7(.Sum(Out[7])
            ,.Cout(Cout)
            ,.A(A[7])
            ,.B(B[7])
            ,.Cin(tmpCout[6]));
endmodule