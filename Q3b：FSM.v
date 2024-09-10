module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
parameter S0 = 3'd0,S1= 3'd1,S2= 3'd2, S3 = 3'd3 ,S4 = 3'd4 ; 
    reg [2:0] state ;
    reg [2:0] next_state ; 
    
    
    always @(posedge clk)begin
        if (reset)begin
            state <= S0;
        end
        else begin
            state <= next_state;
        end
    end
    
    always @(*)begin
        case(state)
            S0:begin
                next_state = (x==1'b1)? S1:S0;
            end
            S1:begin
                next_state = (x==1'b1)? S4:S1;
            end
            S2:begin
                next_state = (x==1'b1)? S1:S2;
            end
            S3:begin
                next_state = (x==1'b1)? S2:S1;
            end
            S4:begin
                next_state = (x==1'b1)? S4:S3;
            end
            default:begin
                next_state = S0;
            end
            
        endcase
    end
    
    assign z = (state == S3 || state == S4)? 1'b1:1'b0;
    
    

endmodule
