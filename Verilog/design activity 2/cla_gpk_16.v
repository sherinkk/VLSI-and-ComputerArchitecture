module isum( output sum, input a,b);
	xor xor1 (sum,a,b);
endmodule

module igpk( output out, input a,b);

	reg out;
	reg x;

always @ (a or b)
	begin
	case ({a,b})
	2'b00:out<=0;
	2'b01:out<=x;
	2'b10:out<=x;
	2'b11:out<=1;
	
	endcase
	end
endmodule

module saver(output out, input inp);  
  buf buf1 (out, inp);  
endmodule

module shifter(output gpk_cur, input cur,prev);

	reg gpk_cur;
	always @(cur or prev)
		begin
		case (cur)
		1'b1:gpk_cur<=1;
		1'b0:gpk_cur<=0;
		//1'b1:gpk_cur<=1;
		default:gpk_cur<=prev;
		endcase
		end
endmodule

module carryFinder(output [15:0] carry,input [15:0] gpk_1);

	wire [15:0] gpk_2,gpk_4,gpk_8,gpk_16,gpk_32,gpk_64,gpk_128;
	
	
	shifter s1[15:1] (gpk_2[15:1],gpk_1[15:1],gpk_1[14:0]);
	shifter s2(gpk_2[0],gpk_1[0],1'b0);
	

	
	shifter s9[15:2] (gpk_4[15:2],gpk_2[15:2],gpk_2[13:0]);
	shifter s10 (gpk_4[1],gpk_2[1],1'b0);
	saver save1 (gpk_4[0],gpk_2[0]);
	
	shifter s11[15:4] (gpk_8[15:4],gpk_4[15:4],gpk_4[11:0]);
	shifter s12 (gpk_8[3],gpk_4[3],1'b0);
	saver save2[2:0] (gpk_8[2:0],gpk_4[2:0]);
	
	shifter s13[15:8] (gpk_16[15:8],gpk_8[15:8],gpk_8[7:0]);
	shifter s14 (gpk_16[7],gpk_8[7],1'b0);
	saver save3[6:0] (gpk_16[6:0],gpk_8[6:0]);
	
	shifter s15(gpk_32[15],gpk_16[15],1'b0);
	saver save4[14:0](gpk_32[14:0],gpk_16[14:0]);
	

	saver save_last [15:0](carry[15:0],gpk_32[15:0]);
	
endmodule

module finalSum( output[16:0] fsum, input [15:0] isum, carry);

	isum s1[15:1] (fsum[15:1],isum[15:1],carry[14:0]);
	saver save20 (fsum[0],isum[0]);
	saver save21 (fsum[16],carry[15]);

endmodule

module sixteenTwoBitAdder(output [16:0] out,input [15:0] sum_81,carry_81);

	wire [15:0] i_sum,gpk_1,carry;
	
	isum isum1[15:0](i_sum,sum_81,carry_81);
	
	igpk igpk1[15:0](gpk_1, sum_81,carry_81);	
	carryFinder cF1 (carry,gpk_1);
	
	finalSum fsum (out,i_sum,carry);

endmodule















