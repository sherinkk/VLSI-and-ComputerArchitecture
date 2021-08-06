`include "cla_gpk.v"
module top;

	wire [7:0] gpk_1,carry,i_sum;wire[8:0]f_sum;
	reg [7:0] a,b;

	wire out;
	
	isum isum1[7:0](i_sum, a, b);
	
	igpk igpk1[7:0](gpk_1, a, b);	
	carryFinder cF1 (carry,gpk_1);
	
	finalSum fsum (f_sum,i_sum,carry);
	
	//saver save[7:0](temp,sum);
	
	//shifter s3 (temp[6], temp[6],temp[5]);
	/*
	shifter s1 (temp[7], gpk_1[7],gpk_1[6]);
	shifter s2 (temp[6], gpk_1[6],gpk_1[5]);
	shifter s3 (temp[5], gpk_1[5],gpk_1[4]);
	shifter s4 (temp[4], gpk_1[4],gpk_1[3]);
	shifter s5 (temp[3], gpk_1[3],gpk_1[2]);
	shifter s6 (temp[2], gpk_1[2],gpk_1[1]);
	shifter s7 (temp[1], gpk_1[1],gpk_1[0]);
	shifter s8 (temp[0], gpk_1[0], 1'b0);*/
	initial 
		begin
			a=8'b00000001;
			b=8'b11111110;
			#10 a=8'b10100111;
			#10 b=8'b00000011;
			#10 a=8'b10000001;
				b=8'b00000111;
		end
	
	initial
		begin
			$monitor("%b --- %b  ---  %b ---- %b ----->>>> %b", a, b, gpk_1,carry,f_sum);
		end
endmodule
