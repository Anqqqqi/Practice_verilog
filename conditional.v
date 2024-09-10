module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//
    wire [7:0] inst1, inst2;

    // assign intermediate_result1 = compare? true: false;
	assign inst1 = a<b? a:b; 
    assign inst2 = inst1<c? inst1:c; 
    assign min = inst2 <d ? inst2 :d;


endmodule