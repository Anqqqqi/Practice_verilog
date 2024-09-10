`timescale 1ns/1ns

module RTL(
	input clk,
	input rst_n,
	input data_in,
	output reg data_out
	);


	reg data_in_regQ;
	reg always1out;

	always @(*)begin
		always1out = data_in & (~data_in_regQ);
	end
	
	always @(posedge clk)begin
		if (~rst_n)begin
			data_out  <= 1'h0;
			data_in_regQ <= 1'h0;
			end
		else begin
			data_in_regQ <= data_in ; 
			data_out <= always1out;
		end

	end


endmodule