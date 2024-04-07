// Basic question 3 invterter 
module moduleName (
    module top_module( input in, output out );
	assign out = ~in;
endmodule
);  
endmodule
// AND GATE 
module top_module( 
    input a, 
    input b, 
    output out );
assign out = a&&b;
endmodule
// OR GATE 
module top_module( 
    input a, 
    input b, 
    output out );
assign out = a|b;
endmodule
// NOR Gate\
module top_module( 
    input a, 
    input b, 
    output out );
assign out = ((a==1'b0) && (b==1'b0))?1'b1:1'b0;
endmodule
// NAND Gate
module top_module( 
    input a, 
    input b, 
    output out );
assign out = ((a==1'b0) && (b==1'b0))?1'b0:1'b1;

endmodule
// XNOR fate 
module top_module( 
    input a, 
    input b, 
    output out );
assign out = ((a==b))?1'b1:1'b0;
 
endmodule
// declaring wires 
module top_module(
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n   ); 
    wire and_out1,and_out2,nor_out1;
assign out = nor_out1 ;
assign out_n = ~nor_out1;
assign nor_out1 = and_out2 | and_out1 ;
assign and_out1 = a&&b;
assign and_out2 = c&&d;
endmodule
// vector 0 
module top_module ( 
    input wire [2:0] vec,
    output wire [2:0] outv,
    output wire o2,
    output wire o1,
    output wire o0  ); // Module body starts after module declaration
assign outv = vec[2:0];
assign o2 = vec[2]; 
assign o1 = vec[1]; 
assign o0 = vec[0];
endmodule
//vector  1 
module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );
    assign out_hi = in[15:8];
    assign out_lo = in[7:0];
endmodule
//vector  2 
module top_module( 
    input [31:0] in,
    output [31:0] out );//

    // assign out[31:24] = ...;
    assign out [31:24] = in[7:0];
    assign out [23:16] = in[15:8];
    assign out [15:8] = in[23:16];
    assign out [7:0] = in[31:24];
endmodule
//gates 
module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    assign out_and=in[3] && in[2] && in[1] && in[0] ; 
    assign out_or=in[3] || in[2] ||in[1]||in[0];
    assign out_xor= in[3]^ in[2]^ in[1]^in[0];
endmodule 