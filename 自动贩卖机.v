// use verilog to design the circuite 
// each drink $1.5 , one time only for one coin, accept $0.5 $1 ， can get the change 
/*
useing fsm to solve the problem 
there are 
s0 : initial state , wait for the coin
s1 : accept the coin , $0.5, wait for more coin
s2 : accept the coin , $1, wait for more coin
s3 : accept the coin , 1+0.5 = $1.5 , get the drink, no need for change
s4 : acceot the coin, 1 + 1 = $2, get the drink and get the change $0.5
*/
// input 1 = $1, input 0 = $0.5 // change 0 = 
module (
    input clk,
    input rst_n,// negedge vaild
    input coin,
    output drink_flag
    output change_flag
);
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
parameter s3 = 2'b11;
parameter s4 = 2'b11;
reg [2:0] state, next_state;
//state change
always @(posedge clk or negedge rst_n)begin
    if (!rst_n)begin
        state <= s0;
    end
    else begin
        state <= next_state;
    end
end
// next state logic
always @(*)begin
    case(state)// input, have three conditions, 0.5,1, and non coin
        s0:next_state = coin[1] ? s2 : (coin[0] ? s1 :IDLE);
        s1:next_state = coin[1] ? s3 : (coin[0] ? s2 : s1);
        s2:next_state = coin[1] ? s4 : (coin[0] ? s3 : s2);
        s3:next_state = coin[1] ? s2 : (coin[0] ? s1 :IDLE);
        s4:next_state = coin[1] ? s2 : (coin[0] ? s1 :IDLE);
        default : next_state = s0;
    endcase
end
// output logic
assign drink_flag = (state == s3) || (state == s4);
assign change_flag = (state == s4); 
endmodule