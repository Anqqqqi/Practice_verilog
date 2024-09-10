module serialdet(//moore non overlapping sequence detector
    input clk,
    input reset,
    input d,
    output q

);

reg [2:0] state, nextstate;

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;

always @ (posedge clk or negedge clk)begin
    
    if(reset)
        state <= s0;
    else
        state <= nextstate;
end

always @(*)begin
    case (state)
    S0 : begin
        if(d)
            nextstate = S1;
        else
            nextstate = S0;
    end
    S1 : begin
        if(d)
            nextstate = S1;
        else
            nextstate = S2;
    end
    S2 : begin
        if(d)
            nextstate = S1;
        else
            nextstate = S3;
    end
    S3 : begin
        if(d)
            nextstate = S4;
        else
            nextstate = S0;
    end
    S4 : begin
        if(d)
            nextstate = S1;
        else
            nextstate = S0;
    end
    default : nextstate = S0;

    endcase
end

assign q = (state == S4);


endmodule