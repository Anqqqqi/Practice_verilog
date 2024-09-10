module top_module (
    input clk,
    input [2:0] y,
    input x,
    output Y0,
    output z
);

    parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2;
    parameter S3 = 3'd3, S4 = 3'd4;
 
    reg [2:0]	next_state;
    

    always@(*)begin
        case(y)
            S0:begin
                next_state = x ? S1 : S0;
            end
            S1:begin
                next_state = x ? S4 : S1;
            end
            S2:begin
                next_state = x ? S1 : S2;
            end
            S3:begin
                next_state = x ? S2 : S1;
            end
            S4:begin
                next_state = x ? S4 : S3;
            end
            default:begin
                next_state = S0;
            end
        endcase
    end
    
    assign Y0 = (next_state == S1 || next_state == S3);
    assign z = (y == S3 || y == S4);    

endmodule