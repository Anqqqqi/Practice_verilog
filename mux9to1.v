module top_module( 
    input [15:0] a, b, c, d, e, f, g, h, i,
    input [3:0] sel,
    output [15:0] out );
    always @(*)begin
        case(sel)
        4'b0000:out = a;
        4'b0001:out = b;     
        4'b0010:out = c;
        4'b0011:out = d;
        4'b0100:out = e;
        4'b0101:out = f;
        4'b0110:out = g;
        4'b0111:out = h;
        4'b1000:out = i;
  		default: out = 16'hffff;
        endcase 
    end
endmodule

/*module top_module(  
    input [255:0] in,
    input [7:0] sel,
    output out );
  assign out = in[sel];
endmodule */
/*module mux256to1v 
(
  input [1023:0] in,
  input [7:0] sel,
  output [3:0] out  
);
  

  assign out[0] = in[4*sel+0];
  assign out[1] = in[4*sel+1];
  assign out[2] = in[4*sel+2];
  assign out[3] = in[4*sel+3];

endmodule*/