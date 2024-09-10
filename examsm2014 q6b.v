module top_module (
    input [3:1] y,
    input w,
    output Y2);
	
    parameter A = 3'b000;
    parameter B = 3'b001;
    parameter C = 3'b010;
    parameter D = 3'b011;
    parameter E = 3'b100;
    parameter F = 3'b101;
    
    reg [2:0] state ;
    reg [2:0] next_state ;
 	assign state =y;
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
            
    assign  Y2 =(next_state == D )|| (next_state == C); 
endmodule
// need to find out when Y2 is 1, when the second bit is 1