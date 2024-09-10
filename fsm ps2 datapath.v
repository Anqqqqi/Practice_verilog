module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2

    localparam S1 = 3'd0, S2 = 3'd1, S3 = 3'd2, DONE = 3'd3;
    reg [2:0]	status;
    reg [2:0]	next_status;
    reg [23:0]  out_bytes_reg;
    // State transition logic (combinational)
    always @(*)begin
            case (status)
                S1:begin
                    next_status <= (in[3])?S2:S1;
                    out_bytes_reg[23:16] <= in;
                end
                S2:begin
                    next_status <= S3;
                    out_bytes_reg[15:8] <= in;
                end
                S3:begin
                    next_status <= DONE;
                    out_bytes_reg[7:0] <= in;
                end
                DONE:begin
                    next_status <= (in[3])?S2:S1;
                    out_bytes_reg <= out_bytes_reg;
                end
                default:begin
                    next_status <= S1; 
                end
                endcase
    end
    
    // State flip-flops (sequential)
    always @(posedge clk)begin
        if (reset)begin
            status <= S1;
        end
        else begin
            status <= next_status; 
        end
        
    end
                
 	
    // Output logic
    assign done = (status==DONE)?1:0;
    
    assign out_bytes = (done)? out_bytes_reg : 23'd0;
endmodule

