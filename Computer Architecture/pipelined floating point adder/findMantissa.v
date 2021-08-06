
`include "adder.v"
`include "sync.v"
module find_mantissa(sum,carry,i1,i2,cin,clk);

input [23:0] i1,i2;
input cin,clk;
output [23:0] sum;
output carry;

wire cin_f;

wire [31:0] a,b;
wire [32:0] c;

assign a[23:0] = i1[23:0];
assign b[23:0] = i2[23:0];
assign a[31:24] = 8'b0;
assign b[31:24] = 8'b0;

wire [31:0] i_sum,gpk_1;

//thirtyTwoBitAdder t1 (c,a,b);
isum isum1[31:0](i_sum, a, b);   //initial sum - xor of the two inputs
igpk igpk1[31:0](gpk_1, a, b);	//labelling the bits of 'gpk_1' as generate(g),propogate(g) or kill(k)
carryAndOutFinder cF1 (c,gpk_1,i_sum,clk); //finding carry from 'gpk_1' and then final sum (xor of initial sum and carry) 
sync s1 (cin_f,cin,clk);

assign sum[23:0] = c[23:0];
assign carry = {!cin_f}&c[24];



endmodule