module COUNTER_17(
    output DONE,
    input CLEAR,
    input CLOCK);
    reg [17:0] intMem;
    assign DONE=intMem[17];
    initial begin
        intMem<=18'b100000000000000000; // Initialized to DONE=1
    end
    always@(posedge CLOCK) begin
        case({DONE,CLEAR})
            2'b00:  intMem<=(intMem<<1); // DONE and CLEAR are 0, Count
            2'b01,2'b11:  intMem<=18'b000000000000000001; // CLEAR=1 , reset
            2'b10:  intMem<=intMem; // DONE=1, HOLD
        endcase
    end
endmodule