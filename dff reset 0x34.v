//Create 8 D flip-flops with active high synchronous reset. The flip-flops must be reset to 0x34 rather than zero. All DFFs should be triggered by the negative edge of clk.
// 0x34 16base = decimal 52 in verilog express 8'h34 == 8'd52
/* 0x34 in hexadecimal translates to:
3 in the hexadecimal place (16^1) = 3 * 16 = 48
4 in the unit place (16^0) = 4 * 1 = 4
Adding them together: 48 + 4 = 52 in decimal.*/
module top_module (
    input clk,
    input reset,
    input [7:0] d,
    output [7:0] q
);

    always @(negedge clk)begin
        if (reset)begin
            q<= 8'd52; // 8'h34 
        end
        else begin
            q <=d;
       end
    end
endmodule