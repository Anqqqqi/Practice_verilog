module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
        if (areset) begin
            next_state <= B;
        end
        else begin
            case(state)
                B:begin
                    if(in == 1'b1)begin
                        next_state <= B;
                    end
                    else begin
                        next_state <= A;
                    end
                end
                A :begin
                    if(in == 1'b1)begin
                        next_state <= A;
                    end
                    else begin
                        next_state <=B;
                    end
                end
            endcase
          end       

        
    end

    always @(posedge clk or posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (areset)begin
            state <= B;
        end
        else begin
            state <=next_state;
        end
    end
	always @(*) begin
    // Output logic
    // assign out = (state == ...);
        if (state == B)begin
            out <= 1'b1;
        
        end
        else begin
            out <= 1'b0;
        end
    end
                 
endmodule