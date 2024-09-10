// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;
 
    parameter A = 1'b0;
    parameter B = 1'b1;
 
    reg current_state, next_state;
    
    always@(posedge clk)begin
        if(reset)begin
            current_state <= B;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@(*)begin
        case(current_state)
            B:begin
                if(in == 1'b1)begin
                    next_state = B;
                end
                else begin
                    next_state = A;
                end
            end
            A:begin
                if(in == 1'b1)begin
                    next_state = A;
                end
                else begin
                    next_state = B;
                end
            end
        endcase
    end
    
    always@(*)begin
        if(current_state == B)begin
            out = 1'b1;
        end
        else begin
            out = 1'b0;
        end
    end
 
 
endmodule
// 两段式写法