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

module carryFinder(output [7:0] carry,input [7:0] gpk_1);

	wire [7:0] gpk_2,gpk_4,gpk_8,gpk_16;
	
	
	shifter s1[7:1] (gpk_2[7:1],gpk_1[7:1],gpk_1[6:0]);
	shifter s2(gpk_2[0],gpk_1[0],1'b0);
	
	/*
	shifter s1 (gpk_2[7], gpk_1[7],gpk_1[6]);
	shifter s2 (gpk_2[6], gpk_1[6],gpk_1[5]);
	shifter s3 (gpk_2[5], gpk_1[5],gpk_1[4]);
	shifter s4 (gpk_2[4], gpk_1[4],gpk_1[3]);
	shifter s5 (gpk_2[3], gpk_1[3],gpk_1[2]);
	shifter s6 (gpk_2[2], gpk_1[2],gpk_1[1]);
	shifter s7 (gpk_2[1], gpk_1[1],gpk_1[0]);
	shifter s8 (gpk_2[0], gpk_1[0], 1'b0);*/
	
	shifter s9[7:2] (gpk_4[7:2],gpk_2[7:2],gpk_2[5:0]);
	shifter s10 (gpk_4[1],gpk_2[1],1'b0);
	saver save1 (gpk_4[0],gpk_2[0]);
	
	shifter s11[7:4] (gpk_8[7:4],gpk_4[7:4],gpk_4[3:0]);
	shifter s12 (gpk_8[3],gpk_4[3],1'b0);
	saver save2[2:0] (gpk_8[2:0],gpk_4[2:0]);
	
	shifter s13 (gpk_16[7],gpk_8[7],1'b0);
	saver save3[6:0] (gpk_16[6:0],gpk_8[6:0]);
	
	saver save_last [7:0](carry,gpk_16);
	
endmodule

module finalSum( output[8:0] fsum, input [7:0] isum, carry);

	isum s1[7:1] (fsum[7:1],isum[7:1],carry[6:0]);
	saver save20 (fsum[0],isum[0]);
	saver save21 (fsum[8],carry[7]);

endmodule
















