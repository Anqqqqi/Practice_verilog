// 4bits 的 binary to gray code 
module binary_to_gray_code(
    input [3:0] binary,
    output [3:0] gray
);
   always @(posedge clk or negedge rst_n) begin
       if(~rst_n) begin
           gray <= 4'b0;
       end else begin
           gray <= binary ^ (binary >> 1); // data shift right 1 bit, and then xor
       end//shift one bit 补0 0和本身xor还是本身 
   end
endmodule