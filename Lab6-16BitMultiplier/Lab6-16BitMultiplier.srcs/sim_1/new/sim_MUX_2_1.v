module sim_MUX_2_1();
    reg CLOCK;
    reg S;
    wire OUT;
    MUX_2_1 sim(
        .OUT(OUT),
        .S(S),
        .OPT0(0),
        .OPT1(CLOCK));
    integer i;
    initial begin
        S<=0;
        for(i=0;i<15;i=i+1) begin
            #5 CLOCK=i%2;   
        end         
        S<=1;
        for(i=0;i<15;i=i+1) begin
            #5 CLOCK=i%2;            
        end
    end
endmodule