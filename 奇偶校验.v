/*
一个输入序列是8位（[7:0]）其中七位是数据位[6:0]，一位是奇校验位[7],设计一个检测模块
其输入为result(result为0代表奇偶校验正确，result为1代表奇偶校验错误)
*//*奇偶校验位有两种类型：偶校验位与奇校验位。
以偶校验位来说，如果一组给定数据位中1的个数是奇数，补一个bit为1，使得总的1的个数是偶数。例：0000001, 补一个bit为1, 00000011。
以奇校验位来说，如果给定一组数据位中1的个数是奇数，补一个bit为0，使得总的1的个数是奇数。例：0000001, 补一个bit为0, 00000010。
*/
//odd test
module oddtest(
    input [7:0] data,
    output result
);
wire oddtest ; 
assign oddtest = data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6];
assign result = (data[7] == oddtest ? 1 : 0 );
endmodule 
// even test
module eventest(
    input [7:0] data,
    output result
);
wire oddtest ; 
assign oddtest = data[0]^data[1]^data[2]^data[3]^data[4]^data[5]^data[6];
assign result = (data[7] == oddtest ? 0 : 1 );
endmodule 