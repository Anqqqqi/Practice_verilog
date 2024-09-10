module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT = 2'd0, RIGHT = 2'd1, GROUND_LEFT = 2'd2, GROUND_RIGHT = 2'd3;
    reg	[1:0]	current_state;
    reg [1:0]	next_state;
    
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
                if (ground)begin
                    if (bump_left)begin
                        next_state <=RIGHT;
                    end
                    else begin
                         next_state <=LEFT;
                    end
                end
                else begin
                    next_state <= GROUND_LEFT;
                end
               // next_state = ground ? (bump_left ? RIGHT : LEFT) : GROUND_LEFT;
            end
            RIGHT:begin
                if (ground)begin
                    if (bump_right)begin
                        next_state <=LEFT;
                    end
                    else begin
                         next_state <=RIGHT;
                    end
                end
                else begin
                    next_state <= GROUND_RIGHT;
                end
                //next_state = ground ? (bump_right ? LEFT : RIGHT) : GROUND_RIGHT;
            end
            GROUND_LEFT:begin
                if (ground)begin
                        next_state <=LEFT;
                    end
                    else begin
                         next_state <=GROUND_LEFT;
                    end
                //next_state = ground ? LEFT : GROUND_LEFT;
            end
            GROUND_RIGHT:begin
                //next_state = ground ? RIGHT : GROUND_RIGHT;
                 if (ground)begin
                        next_state <=RIGHT;
                    end
                    else begin
                         next_state <=GROUND_RIGHT;
                    end
            end
            default:begin
                next_state = LEFT;
            end
        endcase
    end    
    
    assign walk_left = (current_state == LEFT);
    assign walk_right = (current_state == RIGHT);
    assign aaah = (current_state == GROUND_LEFT || current_state == GROUND_RIGHT);
    

endmodule
