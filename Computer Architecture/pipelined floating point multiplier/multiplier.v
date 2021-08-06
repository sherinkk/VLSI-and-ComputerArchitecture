`include "./tools/three_row_adder.v"
`include "./tools/pp.v"
`include "./tools/cla_gpk.v"

module dff(d,clk,clear,q); 

input d, clk, clear; 
output reg q; 

always@(posedge clk) 
begin
    if(clear== 1)
        q <= 0;
    else 
        q <= d;
  
end 
endmodule


module WM(a,b,clk,out);

input[31:0] a,b;
input clk;
output[64:0] out;


wire [31:0][63:0] pp;
PP PP1(a,b,pp);

// -------- level 1 -------------
wire [63:0] sum_11,sum_12,sum_13,sum_14,sum_15,sum_16,sum_17,sum_18,sum_19,sum_110,carry_11,carry_12,carry_13,carry_14,carry_15,carry_16,carry_17,carry_18,carry_19,carry_110;
wire reg [63:0] sumf_11,sumf_12,sumf_13,sumf_14,sumf_15,sumf_16,sumf_17,sumf_18,sumf_19,sumf_110,carryf_11,carryf_12,carryf_13,carryf_14,carryf_15,carryf_16,carryf_17,carryf_18,carryf_19,carryf_110;


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


dff df11[63:0] (sum_11,clk,1'b0,sumf_11);
dff df12[63:0] (sum_12,clk,1'b0,sumf_12);
dff df13[63:0] (sum_13,clk,1'b0,sumf_13);
dff df14[63:0] (sum_14,clk,1'b0,sumf_14);
dff df15[63:0] (sum_15,clk,1'b0,sumf_15);
dff df16[63:0] (sum_16,clk,1'b0,sumf_16);
dff df17[63:0] (sum_17,clk,1'b0,sumf_17);
dff df18[63:0] (sum_18,clk,1'b0,sumf_18);
dff df19[63:0] (sum_19,clk,1'b0,sumf_19);
dff df110[63:0](sum_110,clk,1'b0,sumf_110);

dff df_11[63:0] (carry_11,clk,1'b0,carryf_11);
dff df_12[63:0] (carry_12,clk,1'b0,carryf_12);
dff df_13[63:0] (carry_13,clk,1'b0,carryf_13);
dff df_14[63:0] (carry_14,clk,1'b0,carryf_14);
dff df_15[63:0] (carry_15,clk,1'b0,carryf_15);
dff df_16[63:0] (carry_16,clk,1'b0,carryf_16);
dff df_17[63:0] (carry_17,clk,1'b0,carryf_17);
dff df_18[63:0] (carry_18,clk,1'b0,carryf_18);
dff df_19[63:0] (carry_19,clk,1'b0,carryf_19);
dff df_110[63:0] (carry_110,clk,1'b0,carryf_110);

wire[63:0] row_30,row_31;
dff df_r30[63:0] (pp[30],clk,1'b0,row_30);
dff df_r31[63:0] (pp[31],clk,1'b0,row_31);


// -----------  level 2 --------------
wire [63:0] sum_21,sum_22,sum_23,sum_24,sum_25,sum_26,sum_27,carry_21,carry_22,carry_23,carry_24,carry_25,carry_26,carry_27;
wire [63:0] sumf_21,sumf_22,sumf_23,sumf_24,sumf_25,sumf_26,sumf_27,carryf_21,carryf_22,carryf_23,carryf_24,carryf_25,carryf_26,carryf_27;


	threeRowAdder add21(sumf_11[63:0],carryf_11[63:0],sumf_12[63:0],sum_21[63:0],carry_21[63:0]);
	threeRowAdder add22(carryf_12[63:0],sumf_13[63:0],carryf_13[63:0],sum_22[63:0],carry_22[63:0]);
	threeRowAdder add23(sumf_14[63:0],carryf_14[63:0],sumf_15[63:0],sum_23[63:0],carry_23[63:0]);
	threeRowAdder add24(carryf_15[63:0],sumf_16[63:0],carryf_16[63:0],sum_24[63:0],carry_24[63:0]);
	threeRowAdder add25(sumf_17[63:0],carryf_17[63:0],sumf_18[63:0],sum_25[63:0],carry_25[63:0]);
	threeRowAdder add26(carryf_18[63:0],sumf_19[63:0],carryf_19[63:0],sum_26[63:0],carry_26[63:0]);
	threeRowAdder add27(sumf_110[63:0],carryf_110[63:0],row_30[63:0],sum_27[63:0],carry_27[63:0]);

dff df21[63:0] (sum_21,clk,1'b0,sumf_21);
dff df22[63:0] (sum_22,clk,1'b0,sumf_22);
dff df23[63:0] (sum_23,clk,1'b0,sumf_23);
dff df24[63:0] (sum_24,clk,1'b0,sumf_24);
dff df25[63:0] (sum_25,clk,1'b0,sumf_25);
dff df26[63:0] (sum_26,clk,1'b0,sumf_26);
dff df27[63:0] (sum_27,clk,1'b0,sumf_27);



dff df_21[63:0] (carry_21,clk,1'b0,carryf_21);
dff df_22[63:0] (carry_22,clk,1'b0,carryf_22);
dff df_23[63:0] (carry_23,clk,1'b0,carryf_23);
dff df_24[63:0] (carry_24,clk,1'b0,carryf_24);
dff df_25[63:0] (carry_25,clk,1'b0,carryf_25);
dff df_26[63:0] (carry_26,clk,1'b0,carryf_26);
dff df_27[63:0] (carry_27,clk,1'b0,carryf_27);


wire [63:0] row__31;
dff df_r_31[63:0] (row_31,clk,1'b0,row__31);

// ----------------   level 3 ------------------
	
wire [63:0] sum_31,sum_32,sum_33,sum_34,sum_35,carry_31,carry_32,carry_33,carry_34,carry_35;
wire [63:0] sumf_31,sumf_32,sumf_33,sumf_34,sumf_35,carryf_31,carryf_32,carryf_33,carryf_34,carryf_35;

	threeRowAdder add31(sumf_21[63:0],carryf_21[63:0],sumf_22[63:0],sum_31[63:0],carry_31[63:0]);
	threeRowAdder add32(carryf_22[63:0],sumf_23[63:0],carryf_23[63:0],sum_32[63:0],carry_32[63:0]);
	threeRowAdder add33(sumf_24[63:0],carryf_24[63:0],sumf_25[63:0],sum_33[63:0],carry_33[63:0]);
	threeRowAdder add34(carryf_25[63:0],sumf_26[63:0],carryf_26[63:0],sum_34[63:0],carry_34[63:0]);
	threeRowAdder add35(sumf_27[63:0],carryf_27[63:0],row__31,sum_35[63:0],carry_35[63:0]);



dff df31[63:0] (sum_31,clk,1'b0,sumf_31);
dff df32[63:0] (sum_32,clk,1'b0,sumf_32);
dff df33[63:0] (sum_33,clk,1'b0,sumf_33);
dff df34[63:0] (sum_34,clk,1'b0,sumf_34);
dff df35[63:0] (sum_35,clk,1'b0,sumf_35);

dff df_31[63:0] (carry_31,clk,1'b0,carryf_31);
dff df_32[63:0] (carry_32,clk,1'b0,carryf_32);
dff df_33[63:0] (carry_33,clk,1'b0,carryf_33);
dff df_34[63:0] (carry_34,clk,1'b0,carryf_34);
dff df_35[63:0] (carry_35,clk,1'b0,carryf_35);


// -------- level 4 -----------


wire [63:0] sum_41,sum_42,sum_43,carry_41,carry_42,carry_43;
wire [63:0] sumf_41,sumf_42,sumf_43,carryf_41,carryf_42,carryf_43;

	threeRowAdder add41(sumf_31[63:0],carryf_31[63:0],sumf_32[63:0],sum_41[63:0],carry_41[63:0]);
	threeRowAdder add42(carryf_32[63:0],sumf_33[63:0],carryf_33[63:0],sum_42[63:0],carry_42[63:0]);
	threeRowAdder add43(sumf_34[63:0],carryf_34[63:0],sumf_35[63:0],sum_43[63:0],carry_43[63:0]);


dff df41[63:0] (sum_41,clk,1'b0,sumf_41);
dff df42[63:0] (sum_42,clk,1'b0,sumf_42);
dff df43[63:0] (sum_43,clk,1'b0,sumf_43);


dff df_41[63:0] (carry_41,clk,1'b0,carryf_41);
dff df_42[63:0] (carry_42,clk,1'b0,carryf_42);
dff df_43[63:0] (carry_43,clk,1'b0,carryf_43);


wire [63:0] carryff_35;
dff cff_35[63:0] (carryf_35[63:0],clk,1'b0,carryff_35[63:0]);

// ---------- level 5 ---------

wire [63:0] sum_51,sum_52,carry_51,carry_52;
wire [63:0] sumf_51,sumf_52,carryf_51,carryf_52;

	threeRowAdder add51(sumf_41[63:0],carryf_41[63:0],sumf_42[63:0],sum_51[63:0],carry_51[63:0]);
	threeRowAdder add52(carryf_42[63:0],sumf_43[63:0],carryf_43[63:0],sum_52[63:0],carry_52[63:0]);

dff df51[63:0] (sum_51,clk,1'b0,sumf_51);
dff df52[63:0] (sum_52,clk,1'b0,sumf_52);

dff df_51[63:0] (carry_51,clk,1'b0,carryf_51);
dff df_52[63:0] (carry_52,clk,1'b0,carryf_52);

wire [63:0] carryfff_35;
dff cfff_35[63:0] (carryff_35,clk,1'b0,carryfff_35);

// ---------- level 6 ------------

wire [63:0] sum_61,carry_61;

	threeRowAdder add61(sumf_51[63:0],carryf_51[63:0],sumf_52[63:0],sum_61[63:0],carry_61[63:0]);

wire [63:0] sumf_61,carryf_61,carryff_52,carryffff_35;

dff d61[63:0] (sum_61,clk,1'b0,sumf_61);
dff d62[63:0] (carry_61,clk,1'b0,carryf_61);
dff d63[63:0] (carryf_52,clk,1'b0,carryff_52);
dff d64[63:0] (carryfff_35,clk,1'b0,carryffff_35);


// ------ level 7 -------------
wire [63:0] sum_71,carry_71;

	threeRowAdder add71(sumf_61[63:0],carryf_61[63:0],carryff_52[63:0],sum_71[63:0],carry_71[63:0]);

wire [63:0] sumf_71,carryf_71,carryfffff_35;

dff d71[63:0] (sum_71,clk,1'b0,sumf_71);
dff d72[63:0] (carry_71,clk,1'b0,carryf_71);
dff d73[63:0] (carryffff_35,clk,1'b0,carryfffff_35);

// -------- level 8 ---------

wire [63:0] sum_81,carry_81;

	threeRowAdder add81(sumf_71[63:0],carryf_71[63:0],carryfffff_35[63:0],sum_81[63:0],carry_81[63:0]);

wire [63:0] sumf_81,carryf_81;

dff df81[63:0] (sum_81,clk,1'b0,sumf_81);
dff df_81[63:0] (carry_81,clk,1'b0,carryf_81);

// -------- final level ------
wire [63:0] i_sum,gpk_1,carry;
	
	isum isum1[63:0](i_sum,sumf_81,carryf_81);
	
	igpk igpk1[63:0](gpk_1, sumf_81,carryf_81);	
	carryFinder cF1 (carry,gpk_1);

	finalSum fsum (out,i_sum,carry);

endmodule
