`include "eightBitAdder.v"

module sixteenBitAdder (a, b, cin, sum, cout);

input [15:0] a, b;
input cin;

output [15:0] sum;
output cout;

wire c1;

eightBitAdder ADD_0 (a[7:0], b[7:0], cin, sum[7:0], c1);
eightBitAdder ADD_1 (a[15:8], b[15:8], c1, sum[15:8], cout);

endmodule

