/* 现有一个LED开发板，板上有8个依次排开的LED灯。

需要设计一段verilog程序，来实现驱动LED灯。
时钟clk频率为10Mhz。
当mode模式信号为0时，以0->1->2->3->4->5->6->7->0->1…的顺序，循环点亮LED灯。每次只有一个灯亮，亮灯时间为1秒。
当mode模式信号为1时，以0->2->4->6->1->3->5->7->0->2…的顺序，循环点亮LED灯。每次只有一个灯亮，亮灯时间为1秒。
给出的module接口说明如下，请补充内部代码实现细节。*/

// use fsm 
module led_driver (
    input clk,
    input rstn,
    input mode,
    output [7:0] led
);
parameter [2:0] S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101, S6 = 3'b110, S7 = 3'b111;
reg [2:0] state, next_state;
reg [23:0] counter; // 24-bit counter to count up to 10,000,000


// State transition
    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            state <= S0;
            counter <= 24'd0;
        end else if (counter == 24'd9999999) begin
            state <= next_state;
            counter <= 24'd0;
        end else begin
            counter <= counter + 1;
        end
    end




always @(*)begin
    if (mode)begin
        case(state)
            S0: next_state = S2;
            S2: next_state = S4;
            S4: next_state = S6;
            S6: next_state = S1;
            S1: next_state = S3;
            S3: next_state = S5;
            S5: next_state = S7;
            S7: next_state = S0;
            default: next_state = S0;
        endcase
    end else begin
        case(state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S0;
            default: next_state = S0;
        endcase
    end
end

// Output logic
    always @(*) begin
        case(state)
            S0: led = 8'b00000001;
            S1: led = 8'b00000010;
            S2: led = 8'b00000100;
            S3: led = 8'b00001000;
            S4: led = 8'b00010000;
            S5: led = 8'b00100000;
            S6: led = 8'b01000000;
            S7: led = 8'b10000000;
            default: led = 8'b00000000;
        endcase
    end


endmodule 