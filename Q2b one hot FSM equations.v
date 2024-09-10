module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
	


    parameter A = 3'b000001;
    parameter B = 3'b000010;
    parameter C = 3'b000100;
    parameter D = 3'b001000;
    parameter E = 3'b010000;
    parameter F = 3'b100000;
    



    assign Y1=w&&y[0];
    assign Y3=~w&&(y[1]||y[2]||y[4]||y[5]);
endmodule

