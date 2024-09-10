`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input a,
	output reg match
	);

reg [2:0]state;
reg [2:0]next_state;
localparameter IDLE = 4'd0; //// initial state
localparameter S1 = 4'd1; // State after detecting 0
localparameter S2 = 4'd2; // State after detecting 01
localparameter S3 = 4'd3; // State after detecting 011
localparameter S4 = 4'd4; // State after detecting 0111
localparameter S5 = 4'd5; // State after detecting 01110
localparameter S6 = 4'd6; // State after detecting 011100
localparameter S7 = 4'd7;   // State after detecting 0111000
localparameter S8 = 4'd8; // State after detecting 01110001


always @(posedge clk)begin
	if (!rst_n)begin
		match <= 1'b0;
		state <= IDLE; 
	end
	else begin
		state <= next_state;
	end
end

always @(posedge clk)begin
	case (state)
		IDLE: next_state = (x == 0)?S1:IDLE;//idle 1 s1 0 
        S1: next_state = (x == 1)?S2:S1;
        S2: next_state = (x == 1)?S3:S1;
        S3: next_state = (x == 1)?S4:S1;
        S4: next_state = (x == 0)?S5:IDLE;
		S5: next_state = (x == 0)?S6:IDLE;
        S6: next_state = (x == 0)?S7:IDLE;
        S7: next_state = (x == 1)?S8:S1;
        S8: next_state = (x == 0)?S1:IDLE;
	endcase 
end

//output
assign mastch == (state == S8) ? 1 :0;

endmodule