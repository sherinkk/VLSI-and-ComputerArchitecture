`include "code.v"

module top;

	reg [15:0] a,b;
	wire[31:0]f_sum;
	
	array_mul_16x16 wm1(a,b,f_sum);
	initial 
		begin
			a=16'b0000000000000001;
			b=16'b1111111111111111;
			#10 a=16'b0000000000000010;
			#10 a=16'b0000000000000100;
			#10 a=16'b0000000000001000;
			#10 a=16'b0000000000010000;
			/*#10 b=8'b00000011;
			#10 a=8'b10000001;
				b=8'b00000111;*/
		end
	
	initial
		begin
			$monitor("%b x %b  = %b", a, b,f_sum);
		end
		
endmodule
