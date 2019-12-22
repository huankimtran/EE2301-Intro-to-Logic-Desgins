// SHIFT_LOAD=1 => SHIFT otherwise LOAD
module SHIFTREGISTER_8(
    output [7:0] P_OUT,
    output S_OUT,
    input [7:0] P_IN,
    input S_IN,
    input SHIFT_LOAD,
    input CLOCK);
    reg [7:0] intMem;
    assign S_OUT=intMem[0];
    assign P_OUT=intMem;
    always@(posedge CLOCK) begin
        case(SHIFT_LOAD)
            1'b1:  intMem<=((intMem>>1)|{S_IN,7'd0});    // SHIFT
            1'b0:  intMem<=P_IN;    // LOAD
        endcase
    end
endmodule