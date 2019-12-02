module SUMMER_8(
    output [7:0] OUT,
    output Cout,
    input [7:0] A,
    input [7:0] B,
    input Cin);
    wire [8:0] SUM;
    assign SUM=A+B+Cin;
    assign OUT[7:0]=SUM[7:0];
    assign Cout=SUM[8];
endmodule