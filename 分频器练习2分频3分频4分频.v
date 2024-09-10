/*2'b00 for no division,
2'b01 for division by 2,
2'b10 for division by 3,
2'b11 for division by 4.
duty cycle 50% */

module divider (
    input clk,
    input rstn,
    input[1:0] div_coe,
    output clk_out
);
//internal singal
reg [1:0] counter1;//risedge counter
reg [1:0] counter2;//negedge counter

always @(posedge clk or negedge rstn) begin
    if (!rstn)begin
    end
    else if (counter1 < 2'd2)begin
        counter1 <= 2'd0;
    end
    else begin
        counter1 <= counter1 + 2'd1;
    end
end

always @(negedge clk or negedge rstn) begin
    if (!rstn)begin
        counter2 <= 2'd0;
    end
    else if (counter2 < 2'd2)begin
        counter2 <= 2'd0;
    end
    else begin
        counter2 <= counter1 + 2'd1;
    end
end
//divider 2 
//divider 4 
//divider 3
wire div2;
wire div4;
wire div3;
// set div2 
always @(posedge clk or negedge rstn) begin
    if (!rstn)begin
        div2 <= 1'b0;
    end
    else begin
        div2 <= ~div2;
    end
end
// set div4
always @(posedge div2 or negedge rstn) begin
    if (!rstn)begin
        div4 <= 1'b0;
    end
    else begin
        div4 <= ~div4;
    end
end
// set div3
wire pose;
wire nege;
always @(posedge clk or negedge rstn) begin
    if (!rstn)begin
        pose <= 1'b0;
    end
    else if (counter1 == 2'd0 || counter1 == 2'd1)begin
        pose <= ~pose;
    end
    else begin
        pose <= pose;
    end
end
always @(negedge clk or negedge rstn) begin
    if (!rstn)begin
        nege <= 1'b0;
    end
    else if (counter2 == 2'd0 || counter2 == 2'd1)begin
        nege <= ~nege;
    end
    else begin
        nege <= nege;
    end
end
assign div3 = pose || nege;


//assign clk out 
always @(posedge clk or negedge rstn) begin
    if (!rstn)begin
        clk_out <= 1'b0;  
    end
    else if (div_coe == 2'b00)begin
        clk_out <= clk;
    end
    else if (div_coe == 2'b01)begin
        clk_out <= div2;
    end
    else if (div_coe == 2'b10)begin
        clk_out <= div3;
    end
    else if (div_coe == 2'b11)begin
        clk_out <= div4;
    end
end







endmodule