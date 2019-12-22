module MUX_16_8(
    output [7:0] OUT,
    input S,
    input [7:0] OPT0,
    input [7:0] OPT1);
    assign OUT=({8{!S}}&OPT0)^({8{S}}&OPT1);
endmodule