module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
    wire out1;
    wire out2;
    wire out3;
    bcd_fadd inst1(.a(a[3:0]),.b(b[3:0]),.cin(cin),.cout(out1),.sum(sum[3:0]));
    bcd_fadd inst2(.a(a[7:4]),.b(b[7:4]),.cin(out1),.cout(out2),.sum(sum[7:4]));
    bcd_fadd inst3(.a(a[11:8]),.b(b[11:8]),.cin(out2),.cout(out3),.sum(sum[11:8]));
    bcd_fadd inst4(.a(a[15:12]),.b(b[15:12]),.cin(out3),.cout(cout),.sum(sum[15:12]));
endmodule