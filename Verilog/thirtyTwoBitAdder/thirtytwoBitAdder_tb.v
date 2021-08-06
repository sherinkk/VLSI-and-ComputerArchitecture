`include "thirtytwoBitAdder.v"

module top;
reg [31:0] a, b;
reg cin;
wire [31:0] sum;
wire ca;

thirtytwoBitAdder FullAdd_0 (a, b, cin, sum, ca);

initial
begin
	a = 32'b00000000000000000000000000000000;
	#5 b = 32'b00000000000000000000000000000000;
	#5 cin = 1'b0;
	#5 b = 32'b00000000000000000000000000001111;
	#5 cin = 1'b1;
	#5 a = 32'b00000000000000000000000000010000;
	#5 cin = 1'b1;

end

initial
	$monitor ($time, "  a = %b; b = %b; cin = %b; sum = %b; ca = %b", a, b, cin, sum, ca);

endmodule

