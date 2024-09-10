module div3_50 (
    input clk,
    input rst_n,//
    output div5_clk
);
reg [2:0] pose_cnt;
reg [2:0] nege_cnt;
wire poseclk;
wire negeclk;
//set counter for pose counter 
alwasys @(posedge clk or negedge rst_n)begin
    if(!rst_n)
        pose_cnt <= 2'b00;
    else if(pose_cnt == 2'd4)
        pose_cnt <= 2'b00;
    else
        pose_cnt <= pose_cnt + 1'b1;
end
//set counter for nege counter 
alwasys @(negedge clk or negedge rst_n)
    if(!rst_n)
        nege_cnt <= 2'b00;
    else if(nege_cnt == 2'd4)
        nege_cnt <= 2'b00;
    else
        nege_cnt <= nege_cnt + 1'b1;

//set poseclk and negeclk
always @(posedge clk or negedge rst_n)begin
    if (!rst_n)begin 
        poseclk <= 1'b0;
    end
    else if (pose_cnt == 2'd2 || pose_cnt == 2'd4)begin
        poseclk <= ~poseclk; 
    end
    else begin 
        poseclk <= poseclk; 
    end

end

always @(negedge clk or negedge rst_n)begin
    if (!rst_n)begin 
        negeclk <= 1'b0;
    end
    else if (nege_cnt == 2'd2 || nege_cnt == 2'd4)begin
        negeclk <= ~negeclk; 
    end
    else begin 
        negeclk <= negeclk; 
    end
end


assign div3_clk <= poseclk || negeclk; 

endmodule