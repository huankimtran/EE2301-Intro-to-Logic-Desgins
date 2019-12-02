// SHIFT_LOAD=1 => SHIFT otherwise LOAD
module SHIFTREGISTER_17(
    output [16:0] P_OUT,
    output S_OUT,
    input [16:0] P_IN,
    input S_IN,
    input SHIFT_LOAD,
    input ASYN,
    input [16:0] P_IN_INITIAL,
    input CLOCK);
    reg [16:0] intMem;
    MUX_34_17 asynMux(.OUT(P_OUT),.S(ASYN),.OPT0(intMem),.OPT1(P_IN_INITIAL));
    assign S_OUT=intMem[0];
    always@(posedge CLOCK) begin
        case(ASYN)
            1'b1:  intMem<=P_IN_INITIAL;   // ASYN rises => into Asyn mode, load intMem with P_IN_INITIAL
            1'b0:  begin            
                // Work as usual
                case(SHIFT_LOAD)
                    1'b1:  intMem<=((intMem>>1)|{S_IN,16'd0});    // SHIFT
                    1'b0:  intMem<=P_IN;    // LOAD
                endcase
            end    
        endcase
    end
endmodule