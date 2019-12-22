module MUX_32_16(
    output [15:0] OUT,
    input S,
    input [15:0] OPT0,
    input [15:0] OPT1);
    assign OUT=({16{!S}}&OPT0)^({16{S}}&OPT1);
endmodule