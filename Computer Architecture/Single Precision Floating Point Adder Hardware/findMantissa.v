`include"cla_gpk_32.v"

module find_mantissa(sum,carry,i1,i2,cin);

input [23:0] i1,i2;
input cin;
output [23:0] sum;
output carry;



wire [31:0] a,b;
wire [32:0] c;

assign a[23:0] = i1[23:0];
assign b[23:0] = i2[23:0];
assign a[31:24] = 8'b0;
assign b[31:24] = 8'b0;

thirtyTwoBitAdder tTB1 (c,a,b);

assign sum[23:0] = c[23:0];




assign carry = {!cin}&c[24];



endmodule