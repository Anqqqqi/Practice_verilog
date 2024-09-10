module rst_asy (
    input clk,
    input rst_n,
    output rst_out
);
reg rst_r1;
    always @(posedge clk or negedge rst_n)begin
        if (~rst_n) begin
            rst_r1 <= 1'b0;
            rst_out <= 1'b0;
        end
        else begin
            rst_r1 <= rst_n;
            rst_out <= rst_r1;
        end
    end
endmodule 