module dff(d,clk,clear,q); 

input d, clk, clear; 
output reg q; 

always@(posedge clk) 
begin
    if(clear== 1)
        q <= 0;
    else 
        q <= d;
    //$display("%d\n",$time);  
end 
endmodule

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

module carryAndOutFinder(output [32:0]f_sum,input [31:0] gpk_1,input [31:0] isum,input clk);

	wire [31:0] gpk_2,gpk_4,gpk_8,gpk_16,gpk_32,gpk_64,gpk_128,carry;
	wire k1,k2,k3,k4,k5,k6;
	wire [31:0] isum1,isum2,isum3,isum4,isum5,isum6,isum7;
	assign k1 = 0;
   // -------  level 1 ----------
	
	shifter s1[31:1] (gpk_2[31:1],gpk_1[31:1],gpk_1[30:0]);
	shifter s2(gpk_2[0],gpk_1[0],k1);
	
    wire [31:0] gpk_2_f;
    dff df1[31:0](gpk_2[31:0],clk,1'b0,gpk_2_f[31:0]);
	dff dff1[31:0](isum[31:0],clk,1'b0,isum2[31:0]);
    dff dff_1 (k1,clk,1'b0,k2);
   // -------  level 2  ---------
	
	shifter s9[31:2] (gpk_4[31:2],gpk_2_f[31:2],gpk_2_f[29:0]);
	shifter s10 (gpk_4[1],gpk_2_f[1],k2);
	saver save1 (gpk_4[0],gpk_2_f[0]);

    wire [31:0] gpk_4_f;
    dff df2[31:0](gpk_4[31:0],clk,1'b0,gpk_4_f[31:0]);
	dff dff2[31:0](isum2[31:0],clk,1'b0,isum3[31:0]);
	dff dff_2 (k2,clk,1'b0,k3);

    //-----    level 3   --------
	
	shifter s11[31:4] (gpk_8[31:4],gpk_4_f[31:4],gpk_4_f[27:0]);
	shifter s12 (gpk_8[3],gpk_4_f[3],k3);
	saver save2[2:0] (gpk_8[2:0],gpk_4_f[2:0]);

    wire [31:0] gpk_8_f;
    dff df3[31:0](gpk_8[31:0],clk,1'b0,gpk_8_f[31:0]);
	dff dff3[31:0](isum3[31:0],clk,1'b0,isum4[31:0]);
	dff dff_3 (k3,clk,1'b0,k4);


    //---------  level 4 --------
	
	shifter s13[31:8] (gpk_16[31:8],gpk_8_f[31:8],gpk_8_f[23:0]);
	shifter s14 (gpk_16[7],gpk_8_f[7],k4);
	saver save3[6:0] (gpk_16[6:0],gpk_8_f[6:0]);
	
    wire [31:0] gpk_16_f;
    dff df4 [31:0](gpk_16[31:0],clk,1'b0,gpk_16_f[31:0]);
	dff dff4[31:0](isum4[31:0],clk,1'b0,isum5[31:0]);
	dff dff_4 (k4,clk,1'b0,k5);

    //----------   level 5 --------

	shifter s15[31:16] (gpk_32[31:16],gpk_16_f[31:16],gpk_16_f[15:0]);
	shifter s16 (gpk_32[15],gpk_16_f[15],k5);
	saver save4[14:0] (gpk_32[14:0],gpk_16_f[14:0]);
	
    wire [31:0] gpk_32_f;
    dff df5 [31:0](gpk_32,clk,1'b0,gpk_32_f);
	dff dff5[31:0](isum5[31:0],clk,1'b0,isum6[31:0]);
	dff dff_5 (k5,clk,1'b0,k6);
    
    //------------- level 6 --------
    
	shifter s19(gpk_64[31],gpk_32_f[31],k6);
	saver save6[30:0](gpk_64[30:0],gpk_32_f[30:0]);
	
	dff df6 [31:0](gpk_64[31:0],clk,1'b0,carry[31:0]);
	dff dff6[31:0](isum6[31:0],clk,1'b0,isum7[31:0]);

	//------ last stage which calculates final sum ------
	wire [32:0] fsum;
	finalSum fs1 (fsum,isum7,carry);
	dff dff7[32:0](fsum[32:0],clk,1'b0,f_sum[32:0]);
	
endmodule

module finalSum( output[32:0] fsum, input [31:0] isum, carry);

	isum s1[31:1] (fsum[31:1],isum[31:1],carry[30:0]);
	saver save20 (fsum[0],isum[0]);
	saver save21 (fsum[32],carry[31]);

endmodule















