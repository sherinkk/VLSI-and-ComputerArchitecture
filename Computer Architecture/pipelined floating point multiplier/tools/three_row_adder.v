module threeRowAdder(x,y,z,s,c);

input [63:0] x,y,z;
output [63:0] s,c;

assign s = x^y^z;
assign c[0] = 1'b0;
assign c[63:1] = (x[63:0]&y[63:0]) | (y[63:0]&z[63:0]) | (z[63:0]&x[63:0]);

endmodule


