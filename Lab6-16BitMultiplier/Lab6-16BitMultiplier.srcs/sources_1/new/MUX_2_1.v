module MUX_2_1(
    output OUT,
    input S,
    input OPT0,
    input OPT1);
    wire notS;
    wire opt0ANDout;
    wire opt1ANDout;
    not notSG(notS,S);
    and opt0AND(opt0ANDout,notS,OPT0);
    and opt1AND(opt1ANDout,S,OPT1);
    xor outXOR(OUT,opt0ANDout,opt1ANDout);
endmodule