module dff_serialdetecter (//moore ,overlapping
    input clk,
    input reset,
    input d,
    output reg z

);

reg [3:0] state;

always @(posedge clk or negedge reset)begin
    if (!reset)begin
        state <= 4'b0000;
    end
    else begin
        state <= {state[2:0],d};
    end
end

always @(posedge clk or negedge reset)begin
    if (!reset)begin
        z <= 0;
    end
    else if(state == 4'b1001)begin
        z <= 1;
    end
    else begin
        z <= 0;
    end
end


endmodule