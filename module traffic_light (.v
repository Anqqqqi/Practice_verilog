module traffic_light (
    input wire clk,
    input wire reset,
    input wire timer,
    input wire ped_walk_button,
    input wire inductive_sensor,
    input wire emergency_service_beacon,
    input wire timer_mia,
    output reg [1:0] state
);

    // 定义状态
    typedef enum reg [1:0] {
        RED = 2'b00,
        GREEN = 2'b01,
        YELLOW = 2'b10,
        FAULT = 2'b11
    } state_t;

    state_t current_state, next_state;

    // 状态转移
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= RED; // 初始状态为红灯
        end else begin
            current_state <= next_state; // 状态更新
        end
    end

    // 状态转换逻辑
    always @(*) begin
        // 默认下一个状态为当前状态
        next_state = current_state;
        case (current_state)
            RED: begin
                if (timer) begin
                    next_state = GREEN; // 红灯状态下，计时器信号转到绿灯状态
                end
            end
            GREEN: begin
                if (timer) begin
                    next_state = YELLOW; // 绿灯状态下，计时器信号转到黄灯状态
                end else if (inductive_sensor) begin
                    next_state = RED; // 绿灯状态下，感应器信号转到红灯状态
                end
            end
            YELLOW: begin
                if (timer) begin
                    next_state = RED; // 黄灯状态下，计时器信号转到红灯状态
                end
            end
            FAULT: begin
            
            end
        endcase


        if (emergency_service_beacon) begin
            next_state = GREEN; 
        end else if (timer_mia) begin
            next_state = FAULT; 
        end
    end

   
    always @(posedge clk) begin
        state <= current_state;
    end
endmodule
