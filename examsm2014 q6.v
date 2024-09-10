//next-state signals Y2 and Y4.  the second bit and the fourth bit is 1 
module top_module (
    input clk,
    input reset,     // synchronous reset
    input w,
    output z);
	


    parameter A = 3'd0;
    parameter B = 3'd1;
    parameter C = 3'd2;
    parameter D = 3'd3;
    parameter E = 3'd4;
    parameter F = 3'd5;
    


    reg [2:0] state ;
    reg [2:0] next_state ;

    always @(posedge clk)begin
        if(reset)begin
            state <= A;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*)begin
        case(state)
            A:begin
                next_state = (w)?A:B;
            end
            B:begin
                next_state = (w)?D:C;
            end
            C:begin
                next_state = (w)?D:E;
            end
            D:begin
                next_state = (w)?A:F;
            end
            E:begin
                next_state = (w)?D:E;
            end
            F:begin
                next_state = (w)?D:C;
            end
            default:next_state=A;    
            endcase
        end
    assign z = ((state == E )|| (state == F )) ? 1'b1 : 1'b0;  
endmodule
