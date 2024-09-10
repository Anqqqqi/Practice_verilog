/*Exams/ece241 2014 q1c
Assume that you have two 8-bit 2's complement numbers, a[7:0] and b[7:0]. 
These numbers are added to produce s[7:0]. 
Also compute whether a (signed) overflow has occurred.
*/
module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); //
 
    assign s = a+b;
    assign overflow =(a[7]&&b[7]&&~s[7]) | (~a[7]&&~b[7]&&s[7]);

endmodule
/*1.x y皆为正数时，若x+y<0则说明发生了溢出
2.x y 皆为负数时，若x+y>=0则说明发生了溢出*/