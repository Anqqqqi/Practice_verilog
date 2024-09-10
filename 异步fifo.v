module async_fifo
	#(parameter DATA_WIDTH = 8,
	  parameter PTR_WIDTH = 4,
	  parameter ADDR_WIDTH = PTR_WIDTH-1,
	  parameter DEPTH = 2 ** ADDR_WIDTH)
	(
	input wclk,
	input rclk,
	input wrst_n,
	input rrst_n,
	input winc,
	input rinc,
	input [DATA_WIDTH-1:0] wdata,
	output [DATA_WIDTH-1:0] rdata,
	output wfull,
	output rempty);

logic [PTR_WIDTH-1:0] wptr;
logic [PTR_WIDTH-1:0] rptr;
logic [ADDR_WIDTH-1:0] waddr;
logic [ADDR_WIDTH-1:0] raddr;

logic [DATA_WIDTH-1:0] mem [DEPTH-1:0];

//sync wptr
logic [PTR_WIDTH-1:0] wptr_sync_s0,wptr_sync_s1;
always_ff @(posedge rclk or negedge rrst_n)begin
	if(!rrst_n)begin
		{wptr_sync_s1,wptr_sync_s0} <= 'h0;
	end else begin
		{wptr_sync_s1,wptr_sync_s0} <= {wptr_sync_s0,wptr};
	end
end

//sync_rptr
logic [PTR_WIDTH-1:0] rptr_sync_s0,rptr_sync_s1;
always_ff @(posedge wclk or negedge wrst_n)begin
	if(!wrst_n)begin
		{rptr_sync_s1,rptr_sync_s0} <= 'h0;
	end else begin
		{rptr_sync_s1,rptr_sync_s0} <= {rptr_sync_s0,rptr};
	end
end

//wfull
logic [PTR_WIDTH-1:0] wbin,wbnext;
logic [PTR_WIDTH-1:0] wgnext;
logic wfull_tmp;

always_ff @(posedge wclk or negedge wrst_n)begin
	if(!wrst_n)begin
		{wbin,wptr} <= 'h0;
	end else begin
		{wbin,wptr} <= {wbnext,wgnext};
	end
end

assign wbnext = wbin + (winc && !wfull);
assign wgnext = (wbnext >> 1) ^ wbnext;
assign wfull_tmp = (wgnext == ({~rptr_sync_s1[PTR_WIDTH-1:PTR_WIDTH-2],rptr_sync_s1[PTR_WIDTH-3:0]}));

always_ff @(posedge wclk or negedge wrst_n)begin
	if(!wrst_n)begin
		wfull <= 'h0;
	end else
		wfull <= wfull_tmp;
end

//rempty
logic [PTR_WIDTH-1:0] rbin,rbnext;
logic [PTR_WIDTH-1:0] rgnext;
logic rempty_tmp;

always_ff @(posedge rclk or negedge rrst_n)begin
	if(!rrst_n)begin
		{rbin,rptr} <= 'h0;
	end else begin
		{rbin,rptr} <= {rbnext,rgnext};
	end
end

assign rbnext = rbin + (rinc && !rempty);
assign rgnext = (rbnext >> 1) ^ rbnext;
assign rempty_tmp = (rgnext == wptr_sync_s1);

always_ff @(posedge rclk or negedge rrst_n)begin
	if(!rst_n)begin
		rempty <= 'h1;
	end else
		rempty <= rempty_tmp;
end

//RAM
assign waddr = wbin[PTR_WIDTH-2:0];
assign raddr = wbin[PTR_WIDTH-2:0];

always_ff @(posedge wclk)begin
	if(winc && !wfull)
		mem[waddr] <= wdata;
end

assign rdata = mem[raddr];

endmoduel // async_fifo
