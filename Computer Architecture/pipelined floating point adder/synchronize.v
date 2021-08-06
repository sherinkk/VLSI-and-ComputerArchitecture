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
module synchronize(output s1_o,output s2_o, output [7:0]e1_o,output[7:0]e2_o,input s1,input s2, input [7:0]e1,input[7:0]e2,input clk);

    wire s1_1,s1_2,s1_3,s1_4,s1_5,s1_6,s1_7,s2_1,s2_2,s2_3,s2_4,s2_5,s2_6,s2_7;
    wire [7:0] e1_1,e1_2,e1_3,e1_4,e1_5,e1_6,e1_7,e2_1,e2_2,e2_3,e2_4,e2_5,e2_6,e2_7;

    _dff d1(s1,clk,1'b0,s1_1);
    _dff d2(s1_1,clk,1'b0,s1_2);
    _dff d3(s1_2,clk,1'b0,s1_3);
    _dff d4(s1_3,clk,1'b0,s1_4);
    _dff d5(s1_4,clk,1'b0,s1_5);
    _dff d6(s1_5,clk,1'b0,s1_6);
    _dff d7(s1_6,clk,1'b0,s1_o);
    _dff d_1(s2,clk,1'b0,s2_1);
    _dff d_2(s2_1,clk,1'b0,s2_2);
    _dff d_3(s2_2,clk,1'b0,s2_3);
    _dff d_4(s2_3,clk,1'b0,s2_4);
    _dff d_5(s2_4,clk,1'b0,s2_5);
    _dff d_6(s2_5,clk,1'b0,s2_6);
    _dff d_7(s2_6,clk,1'b0,s2_o);

    _dff   dd1  [7:0](e1,clk,1'b0,e1_1);
    _dff   dd2  [7:0](e1_1,clk,1'b0,e1_2);
    _dff   dd3  [7:0](e1_2,clk,1'b0,e1_3);
    _dff   dd4  [7:0](e1_3,clk,1'b0,e1_4);
    _dff   dd5  [7:0](e1_4,clk,1'b0,e1_5);
    _dff   dd6  [7:0](e1_5,clk,1'b0,e1_6);
    _dff   dd7  [7:0](e1_6,clk,1'b0,e1_o);
    _dff   dd_1  [7:0](e2,clk,1'b0,e2_1);
    _dff   dd_2  [7:0](e2_1,clk,1'b0,e2_2);
    _dff   dd_3  [7:0](e2_2,clk,1'b0,e2_3);
    _dff   dd_4  [7:0](e2_3,clk,1'b0,e2_4);
    _dff   dd_5  [7:0](e2_4,clk,1'b0,e2_5);
    _dff   dd_6  [7:0](e2_5,clk,1'b0,e2_6);
    _dff   dd_7  [7:0](e2_6,clk,1'b0,e2_o);


endmodule
