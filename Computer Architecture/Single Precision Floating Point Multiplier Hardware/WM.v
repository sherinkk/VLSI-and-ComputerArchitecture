`include "./wallace/three_row_adder.v"
`include "./wallace/pp.v"
`include "./wallace/cla_gpk.v"


module WM(a,b,out);

input[31:0] a,b;
output[64:0] out;


wire [31:0][63:0] pp;
PP PP1(a,b,pp);


wire [63:0] sum_11,sum_12,sum_13,sum_14,sum_15,sum_16,sum_17,sum_18,sum_19,sum_110,carry_11,carry_12,carry_13,carry_14,carry_15,carry_16,carry_17,carry_18,carry_19,carry_110;

	threeRowAdder add11(pp[0][63:0],pp[1][63:0],pp[2][63:0],sum_11[63:0],carry_11[63:0]);
	threeRowAdder add12(pp[3][63:0],pp[4][63:0],pp[5][63:0],sum_12[63:0],carry_12[63:0]);
	threeRowAdder add13(pp[6][63:0],pp[7][63:0],pp[8][63:0],sum_13[63:0],carry_13[63:0]);
	threeRowAdder add14(pp[9][63:0],pp[10][63:0],pp[11][63:0],sum_14[63:0],carry_14[63:0]);
	threeRowAdder add15(pp[12][63:0],pp[13][63:0],pp[14][63:0],sum_15[63:0],carry_15[63:0]);
	threeRowAdder add16(pp[15][63:0],pp[16][63:0],pp[17][63:0],sum_16[63:0],carry_16[63:0]);
	threeRowAdder add17(pp[18][63:0],pp[19][63:0],pp[20][63:0],sum_17[63:0],carry_17[63:0]);
	threeRowAdder add18(pp[21][63:0],pp[22][63:0],pp[23][63:0],sum_18[63:0],carry_18[63:0]);
	threeRowAdder add19(pp[24][63:0],pp[25][63:0],pp[26][63:0],sum_19[63:0],carry_19[63:0]);
	threeRowAdder add110(pp[27][63:0],pp[28][63:0],pp[29][63:0],sum_110[63:0],carry_110[63:0]);
	
wire [63:0] sum_21,sum_22,sum_23,sum_24,sum_25,sum_26,sum_27,carry_21,carry_22,carry_23,carry_24,carry_25,carry_26,carry_27;

	threeRowAdder add21(sum_11[63:0],carry_11[63:0],sum_12[63:0],sum_21[63:0],carry_21[63:0]);
	threeRowAdder add22(carry_12[63:0],sum_13[63:0],carry_13[63:0],sum_22[63:0],carry_22[63:0]);
	threeRowAdder add23(sum_14[63:0],carry_14[63:0],sum_15[63:0],sum_23[63:0],carry_23[63:0]);
	threeRowAdder add24(carry_15[63:0],sum_16[63:0],carry_16[63:0],sum_24[63:0],carry_24[63:0]);
	threeRowAdder add25(sum_17[63:0],carry_17[63:0],sum_18[63:0],sum_25[63:0],carry_25[63:0]);
	threeRowAdder add26(carry_18[63:0],sum_19[63:0],carry_19[63:0],sum_26[63:0],carry_26[63:0]);
	threeRowAdder add27(sum_110[63:0],carry_110[63:0],pp[30][63:0],sum_27[63:0],carry_27[63:0]);
	
wire [63:0] sum_31,sum_32,sum_33,sum_34,sum_35,carry_31,carry_32,carry_33,carry_34,carry_35;

	threeRowAdder add31(sum_21[63:0],carry_21[63:0],sum_22[63:0],sum_31[63:0],carry_31[63:0]);
	threeRowAdder add32(carry_22[63:0],sum_23[63:0],carry_23[63:0],sum_32[63:0],carry_32[63:0]);
	threeRowAdder add33(sum_24[63:0],carry_24[63:0],sum_25[63:0],sum_33[63:0],carry_33[63:0]);
	threeRowAdder add34(carry_25[63:0],sum_26[63:0],carry_26[63:0],sum_34[63:0],carry_34[63:0]);
	threeRowAdder add35(sum_27[63:0],carry_27[63:0],pp[31][63:0],sum_35[63:0],carry_35[63:0]);

wire [63:0] sum_41,sum_42,sum_43,carry_41,carry_42,carry_43;

	threeRowAdder add41(sum_31[63:0],carry_31[63:0],sum_32[63:0],sum_41[63:0],carry_41[63:0]);
	threeRowAdder add42(carry_32[63:0],sum_33[63:0],carry_33[63:0],sum_42[63:0],carry_42[63:0]);
	threeRowAdder add43(sum_34[63:0],carry_34[63:0],sum_35[63:0],sum_43[63:0],carry_43[63:0]);

wire [63:0] sum_51,sum_52,carry_51,carry_52;

	threeRowAdder add51(sum_41[63:0],carry_41[63:0],sum_42[63:0],sum_51[63:0],carry_51[63:0]);
	threeRowAdder add52(carry_42[63:0],sum_43[63:0],carry_43[63:0],sum_52[63:0],carry_52[63:0]);

wire [63:0] sum_61,carry_61;

	threeRowAdder add61(sum_51[63:0],carry_51[63:0],sum_52[63:0],sum_61[63:0],carry_61[63:0]);

wire [63:0] sum_71,carry_71;

	threeRowAdder add71(sum_61[63:0],carry_61[63:0],carry_52[63:0],sum_71[63:0],carry_71[63:0]);

wire [63:0] sum_81,carry_81;

	threeRowAdder add81(sum_71[63:0],carry_71[63:0],carry_35[63:0],sum_81[63:0],carry_81[63:0]);


wire [63:0] i_sum,gpk_1,carry;
	
	isum isum1[63:0](i_sum,sum_81,carry_81);
	
	igpk igpk1[63:0](gpk_1, sum_81,carry_81);	
	carryFinder cF1 (carry,gpk_1);
	
	finalSum fsum (out,i_sum,carry);

endmodule
