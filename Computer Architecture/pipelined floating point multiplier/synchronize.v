module _dff(d,clk,clear,q); 

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


module synchronize (output s_o,output[31:0]a_o,output[31:0]b_o,output [7:0]e1_o,output[7:0]e2_o,input s,input[31:0]a,input[31:0]b,input[7:0]e1,input[7:0]e2,input clk);

    wire s_1,s_2,s_3,s_4,s_5,s_6,s_7,s_8;
    wire[31:0] a_1,a_2,a_3,a_4,a_5,a_6,a_7,a_8, b_1,b_2,b_3,b_4,b_5,b_6,b_7,b_8;
    wire [7:0] e1_1,e1_2,e1_3,e1_4,e1_5,e1_6,e1_7,e2_1,e2_2,e2_3,e2_4,e2_5,e2_6,e2_7;

    _dff d_1(s,clk,1'b0,s_1);
    _dff d_2(s_1,clk,1'b0,s_2);
    _dff d_3(s_2,clk,1'b0,s_3);
    _dff d_4(s_3,clk,1'b0,s_4);
    _dff d_5(s_4,clk,1'b0,s_5);
    _dff d_6(s_5,clk,1'b0,s_6);
    _dff d_7(s_6,clk,1'b0,s_7);
    _dff d_8(s_7,clk,1'b0,s_o);

    _dff df1[31:0](a,clk,1'b0,a_1);
    _dff df2[31:0](a_1,clk,1'b0,a_2);
    _dff df3[31:0](a_2,clk,1'b0,a_3);
    _dff df4[31:0](a_3,clk,1'b0,a_4);
    _dff df5[31:0](a_4,clk,1'b0,a_5);
    _dff df6[31:0](a_5,clk,1'b0,a_6);
    _dff df7[31:0](a_6,clk,1'b0,a_7);
    _dff df8[31:0](a_7,clk,1'b0,a_o);

    _dff ddd1[31:0](b,clk,1'b0,b_1);
    _dff ddd2[31:0](b_1,clk,1'b0,b_2);
    _dff ddd3[31:0](b_2,clk,1'b0,b_3);
    _dff ddd4[31:0](b_3,clk,1'b0,b_4);
    _dff ddd5[31:0](b_4,clk,1'b0,b_5);
    _dff ddd6[31:0](b_5,clk,1'b0,b_6);
    _dff ddd7[31:0](b_6,clk,1'b0,b_7);
    _dff ddd8[31:0](b_7,clk,1'b0,b_o);

    _dff __dff1[7:0](e1,clk,1'b0,e1_1);
    _dff __dff2[7:0](e1_1,clk,1'b0,e1_2);
    _dff __dff3[7:0](e1_2,clk,1'b0,e1_3);
    _dff __dff4[7:0](e1_3,clk,1'b0,e1_4);
    _dff __dff5[7:0](e1_4,clk,1'b0,e1_5);
    _dff __dff6[7:0](e1_5,clk,1'b0,e1_6);
    _dff __dff7[7:0](e1_6,clk,1'b0,e1_7);
    _dff __dff8[7:0](e1_7,clk,1'b0,e1_o);

    _dff __dd1[7:0](e2,clk,1'b0,e2_1);
    _dff __dd2[7:0](e2_1,clk,1'b0,e2_2);
    _dff __dd3[7:0](e2_2,clk,1'b0,e2_3);
    _dff __dd4[7:0](e2_3,clk,1'b0,e2_4);
    _dff __dd5[7:0](e2_4,clk,1'b0,e2_5);
    _dff __dd6[7:0](e2_5,clk,1'b0,e2_6);
    _dff __dd7[7:0](e2_6,clk,1'b0,e2_7);
    _dff __dd8[7:0](e2_7,clk,1'b0,e2_o);


endmodule