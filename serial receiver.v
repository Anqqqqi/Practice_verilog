module top_module(
    input clk,
    input in,
    input reset,
    output done
);
parameter IDLE = 4'd0;
parameter START = 4'd1;
parameter DATA = 4'd2;
parameter STOP = 4'd3;
parameter WAIT = 4'd4;

reg [3:0] state;
reg [3:0] next_state;
reg [3:0] counter; 

always @(posedge clk)begin
  if (reset) begin
    state <= IDLE;
    counter <= 4'b0;
  end else begin
    state <= next_state;
  end
end


always @(*)begin
        case(state)
            IDLE:begin
                if(in == 1'b0)begin
                    next_state <= START;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            START:begin
                next_state <= DATA;
            end
            DATA:begin
                if(counter == 8 && in == 1'b1)begin
                    next_state <= STOP;
                end
                else if(counter == 8 && in == 1'b0)begin
                    next_state <= WAIT;
                end
                else begin
                    next_state <= DATA;
                    counter <= counter + 1'b1;
                end
            end
            STOP:begin
                if (in == 1'b1)begin
                    next_state = IDLE;
                end
                else begin
                    next_state = START;
                end
            end
            WAIT:begin
                if (in == 1'b1)begin
                    next_state = IDLE;
                end
                else begin
                    next_state = WAIT;
                end
            end
            default:begin
                next_state = IDLE;
            end
        endcase
    end


assign done = (state == STOP)? 1'b1 : 1'b0;

endmodule