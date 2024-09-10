// moore overlap // not overlap
// detect 0101
module serialdect(
    input x, // input 
    input clk,
    input reset,
    output z
);
reg [2:0] state, next_state;
localparam IDLE = 3'd0; // Initial state
localparam S1 =3'd1; // State after detecting 0
localparam S2 =3'd2; // State after detecting 01
localparam S3 =3'd3; // State after detecting 010
localparam S4 =3'd4; // State after detecting 0101

always @(posedge clk or negedge reset)begin
    if (!reset)begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always @(*)begin 
    next_state = IDLE;
    case(state)
        IDLE: next_state = (x == 0)?S1:IDLE; // S1 0 S2 1 S3 0 S4 1 
        S1: next_state = (x == 1)?S2:S1;
        S2: next_state = (x == 0)?S3:IDLE;
        S3: next_state = (x == 1)?S4:S1;
        S4: next_state = (x == 0)?S3:IDLE;
        // not overlap 
        //S4 : next_state = (x==0)?S1:IDLE;
    endcase
end

always @(posedge clk or negedge reset)begin
    if (!reset)begin
        z <= 1'b0;
    end
    else
		case(state)
			S4		:	z <= 1'b1;	
			default	:	z <= 1'b0;	
		endcase
end

endmodule 