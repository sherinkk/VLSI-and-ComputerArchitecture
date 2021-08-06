
module splitter(a,s,e,m);

input [31:0] a;
output s;
output [7:0] e;
output [22:0] m;

assign s = a[31];
assign e[7:0] = a[30:23];
assign m[22:0] = a[22:0];
endmodule

