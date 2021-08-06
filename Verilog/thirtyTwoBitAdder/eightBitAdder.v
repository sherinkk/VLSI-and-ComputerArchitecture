`include "fourBitAdder.v"

module eightBitAdder (a, b, cin, sum, cout);

input [7:0] a, b;
input cin;

output [7:0] sum;
output cout;

wire c1;

fourBitAdder ADD_0 (a[3:0], b[3:0], cin, sum[3:0], c1);
fourBitAdder ADD_1 (a[7:4], b[7:4], c1, sum[7:4], cout);

endmodule

