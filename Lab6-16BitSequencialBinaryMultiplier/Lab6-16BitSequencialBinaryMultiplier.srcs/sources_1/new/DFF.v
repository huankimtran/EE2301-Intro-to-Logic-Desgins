// A DFF with Asynchronous set
// When AsynSet=1 Q=AsynVal
// else Q= D with new value of D will be set on Positive clock of Clk
module DFF(
        output reg Q,
        output P,
        input  D,
        input  Clk,
        input  AsynSet,
        input  AsynVal);
        assign P=!Q;
        MUX_2_1 mux(.Out(Q),.S(AsynSet),.Opt_0(Q),.Opt_1(AsynVal)); // When AsynSet=0 but no Clock yet, Q will hold
        always @(posedge Clk)
        begin
            // Always let change Q on positive edge of clock and AsynSet=0
            if(AsynSet==0)
                Q<=D;                   
        end
endmodule