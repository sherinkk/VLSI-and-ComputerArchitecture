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

module carryFinder(output [63:0] carry,input [63:0] gpk_1);

	wire [63:0] gpk_2,gpk_4,gpk_8,gpk_16,gpk_32,gpk_64,gpk_128;
	
	
	shifter s1[63:1] (gpk_2[63:1],gpk_1[63:1],gpk_1[62:0]);
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
	
	shifter s9[63:2] (gpk_4[63:2],gpk_2[63:2],gpk_2[61:0]);
	shifter s10 (gpk_4[1],gpk_2[1],1'b0);
	saver save1 (gpk_4[0],gpk_2[0]);
	
	shifter s11[63:4] (gpk_8[63:4],gpk_4[63:4],gpk_4[59:0]);
	shifter s12 (gpk_8[3],gpk_4[3],1'b0);
	saver save2[2:0] (gpk_8[2:0],gpk_4[2:0]);
	
	shifter s13[63:8] (gpk_16[63:8],gpk_8[63:8],gpk_8[55:0]);
	shifter s14 (gpk_16[7],gpk_8[7],1'b0);
	saver save3[6:0] (gpk_16[6:0],gpk_8[6:0]);
	
	shifter s15[63:16] (gpk_32[63:16],gpk_16[63:16],gpk_16[47:0]);
	shifter s16 (gpk_32[15],gpk_16[15],1'b0);
	saver save4[14:0] (gpk_32[14:0],gpk_16[14:0]);
	
	shifter s17[63:32] (gpk_64[63:32],gpk_32[63:32],gpk_32[31:0]);
	shifter s18 (gpk_64[31],gpk_32[31],1'b0);
	saver save5 [30:0] (gpk_64[30:0],gpk_32[30:0]);
	
	shifter s19(gpk_128[63],gpk_64[63],1'b0);
	saver save6[62:0](gpk_128[62:0],gpk_64[62:0]);
	
	saver save_last [63:0](carry[63:0],gpk_128[63:0]);
	
endmodule

module finalSum( output[64:0] fsum, input [63:0] isum, carry);

	isum s1[63:1] (fsum[63:1],isum[63:1],carry[62:0]);
	saver save20 (fsum[0],isum[0]);
	saver save21 (fsum[64],carry[63]);

endmodule
















