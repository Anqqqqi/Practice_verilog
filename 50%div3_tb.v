`timescale 1ns/1ps
module f3_tb();
reg clk;
reg rst_n;
wire clk2;

f3 u1(.clk(clk),.rst_n(reset),.clk2(out));

always
#5 clk = ~clk;

initial
begin
clk = 0;
rst_n = 0;
#15
rst_n = 1;
#30
rst_n = 0;
#100
$stop;
end
endmodule
