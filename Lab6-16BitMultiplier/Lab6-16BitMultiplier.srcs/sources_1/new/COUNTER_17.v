module COUNTER_17(
    output DONE,
    input CLEAR,
    input CLOCK);
    reg [17:0] intMem;
    assign DONE=intMem[17];
    always@(posedge CLOCK) begin
        case({CLOCK,CLEAR})
            2'b00:  intMem<=intMem; // Hold, although this case will never happen
            2'b01:  intMem<=17'b000000000000000001; // Reset counter
            2'b10:  intMem<=(intMem<<1);    // Count
            2'b11:  intMem<=17'b000000000000000001; // Not sure which one is this, but reset to make sure
        endcase
    end
endmodule