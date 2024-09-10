/*使用verilog，完成同步FIFO的设计，
其中数据位宽为8位，FIFO的深度为16，
其中输入端口为clk,rst_n（复位信号）,write_en（写使能）,read_en（读使能）,data_in，
输出端口为empty（空信号）,full（满信号）,data_out
*/


module synfifo (
    input clk,
    input rst_n, // nedegative vaild reset
    input wr_en, // write enable
    input rd_en, // read enable
    input reg[7:0] data_in, // input data bendwidth 8bits
    output reg[7:0] data_out, // output data bendwidth 8bits
    output empty, // fifo empty flag
    output full // fifo full flag
    
);
parameter DEPTH = 16;
reg [7:0] fifo[0:DEPTH-1];// fifo ram depth 16
reg [4:0] wr_ptr = 4'b0;// write pointer 2^4 = 16, need to save 1 bits for change 
reg [4:0] rd_ptr = 4'b0;// read pointer 2^4 = 16
//using gray code 
wire [4:0] wr_gray_ptr;
wire [4:0] rd_gray_ptr;
// assign binary to gray code 
assign wr_gray_ptr = wr_ptr ^ (wr_ptr >> 1);
assign rd_gray_ptr = rd_ptr ^ (rd_ptr >> 1);

// set empty and full flag 
assign empty = (wr_gray_ptr == rd_gray_ptr);// when 
assign full = (wr_gray_ptr[2:0]==rd_gray_ptr[2:0]) && (wr_gray_ptr[3] == !rd_gray_ptr[3])&& (wr_gray_ptr[4] == !rd_gray_ptr[4]);

//assign wr pointer 
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        wr_ptr <= 5'b0_0000;
else if (wr_en && !full)
        begin
        if(wr_ptr < 5'b1_1111)
        wr_ptr <= wr_ptr + 1'b1;
        else
        wr_ptr <= 5'b0_0000;
        end
else
        wr_ptr <= wr_ptr;

//assign rd pointer
always @(posedge clk or negedge rst_n)
    if(!rst_n)
        rd_ptr <= 5'b0_0000;
else if (rd_en && !empty)
        begin
        if(rd_ptr < 5'b1_1111)
        rd_ptr <= rd_ptr + 1'b1;
        else
        rd_ptr <= 5'b0_0000;
        end
else
        rd_ptr <= rd_ptr;
//assign wr in data
always@(posedge clk)
    if(wr_en && !full)begin
        data[wr_ptr] <= data_in;
    end
    else begin
    data[wr_ptr] <= data[wr_ptr];
    end

always@(posedge clk or negedge rst_n)
    if(!rst_n)begin
        data_out <= 8'h00;
    end
    else if(rd_en && !empty)begin
        data_out <= data[rd_ptr];
    end
    else begin
        data_out <= 8'h00;
    end




endmodule 