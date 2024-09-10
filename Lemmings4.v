module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter LEFT = 4'd0, RIGHT = 4'd1, GROUND_LEFT = 4'd2, GROUND_RIGHT = 4'd3;
    parameter DIGGING_LEFT = 4'd4, DIGGING_RIGHT = 4'd5, SPLATTER = 4'd6, AAAH_END = 4'd7;
    reg	[3:0]	current_state;
    reg [3:0]	next_state;
    
    
    reg [4:0]	counter;
    always@(posedge clk or posedge areset)begin
        if(areset)begin
            counter <= 5'd0;
        end
        else if(next_state == GROUND_LEFT || next_state == GROUND_RIGHT)begin
            counter <= counter + 1'b1;
        end
        else begin
            counter <= 5'd0;
        end
    end
    
    always@(posedge clk or posedge areset)begin
        if(areset)begin
            current_state <= LEFT;
        end
        else begin
            current_state <= next_state;
        end
    end
    
    always@(*)begin
        case(current_state)
            LEFT:begin
                next_state = ground ? (dig ? DIGGING_LEFT : (bump_left ? RIGHT : LEFT)) : GROUND_LEFT;
            end
            RIGHT:begin
                next_state = ground ? (dig ? DIGGING_RIGHT : (bump_right ? LEFT : RIGHT)) : GROUND_RIGHT;
            end
            GROUND_LEFT:begin
                next_state = ground ? LEFT : (counter == 5'd20 ? SPLATTER : GROUND_LEFT);
            end
            GROUND_RIGHT:begin
                next_state = ground ? RIGHT : (counter == 5'd20 ? SPLATTER : GROUND_RIGHT);
            end
            DIGGING_LEFT:begin
                next_state = ground ? DIGGING_LEFT : GROUND_LEFT;
            end
            DIGGING_RIGHT:begin
                next_state = ground ? DIGGING_RIGHT : GROUND_RIGHT;
            end
            SPLATTER:begin
                next_state = ground ? AAAH_END : SPLATTER;
            end
            AAAH_END:begin
                next_state = AAAH_END;
            end
            default:begin
                next_state = LEFT;
            end
        endcase
    end    
    
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
    assign digging = (current_state == DIGGING_LEFT || current_state == DIGGING_RIGHT);
    assign aaah = (current_state == GROUND_LEFT || current_state == GROUND_RIGHT || current_state == SPLATTER);   
endmodule