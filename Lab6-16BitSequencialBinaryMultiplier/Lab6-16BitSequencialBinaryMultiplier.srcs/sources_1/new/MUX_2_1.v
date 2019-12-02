//  Mux 2 to 1
module MUX_2_1(
    output Out,
    input S,
    input Op_0,
    input Op_1);
    wire notS;
    assign Out=(S&Op_1)^((!S)&Op_0);
endmodule