// 1-bit full adder
module FULLADDER(
    output Sum,
    output Cout,
    input A,
    input B,
    input Cin);
    //Full adder is two half adder, so
    assign Cout=(A|B)&(A|Cin)&(B|Cin); //Cout=1 if set {A,B,Cin} has at least two 1s
    assign Sum=A^B^Cin; // Sum is 1 if set{A,B,Cin} has a odd number of 1s
endmodule