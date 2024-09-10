module timeclk3 (//delay one cycle to three cycle , slow the frequence 
    input clk,
    input reset,
    output q,
    
);
reg [1:0] counter;

always @(posedge clk )begin
    if (reset)
        counter <= 2'b00;
        q <= 1'b0;
    
    else if (counter == 2'b10)begin
        counter <= 2'b00;
        q <= ~q;
    end
    else begin
        counter <= counter + 1;
        q <= q;
    end


end


endmodule