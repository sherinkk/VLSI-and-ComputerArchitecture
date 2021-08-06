`include "splitter.v"
`include "multiplier.v"
`include "synchronize.v"



module is_nan (output out,input[31:0]a,input[31:0]b);
    assign out = ((&a[30:23] == 1'b1) && (|a[22:0] == 1'b1))||((&b[30:23] == 1'b1) && (|b[22:0] == 1'b1)) ? 1'b1 : 1'b0;
    
endmodule

module is_inf (output out,input[31:0]a,input[31:0] b,input isnan);
    assign out = ((&a[30:23] == 1'b1) && !isnan)||((&b[30:23] == 1'b1) && !isnan) ? 1'b1 : 1'b0;
endmodule

module is_zero (output out,input[31:0]a,input [31:0]b);
    assign out = (|a == 1'b0)||(|b == 1'b0) ? 1'b1 : 1'b0;
endmodule


module multiplier(output[31:0]out,input[31:0]a,input[31:0]b,input clk);


    //splitter ----level 1 ---------
    wire [31:0] a_1,b_1, a_2,b_2, a_3,b_3;
    wire s1,s2,  s1_1,s2_1;
    wire [7:0] e1,e2,  e1_1,e2_1, e1_2,e2_2, e1_3,e2_3;
    wire [22:0] m1,m2,  m1_1,m2_1, m1_2,m2_2, m1_3,m2_3;
    splitter sp1 (a,s1,e1,m1);
    splitter sp2 (b,s2,e2,m2);

    dff df1(s1,clk,1'b0,s1_1);
    dff df2(s2,clk,1'b0,s2_1);
    dff df3[7:0](e1,clk,1'b0,e1_1);
    dff df4[7:0](e2,clk,1'b0,e2_1);
    dff df5[22:0](m1,clk,1'b0,m1_1);
    dff df6[22:0](m2,clk,1'b0,m2_1);
    dff df7[31:0](a,clk,1'b0,a_1);
    dff df8[31:0](b,clk,1'b0,b_1);

    
    //sign ----------level 2 ----------

    wire sign,sign_1,sign_2;
    wire[7:0] exponent,exponent_1;
    wire[22:0] mantissa,mantissa_1;

    assign sign = s1_1^s2_1;

    dff df21(sign,clk,1'b0,sign_1);
    dff df22[7:0](e1_1,clk,1'b0,e1_2);
    dff df23[7:0](e2_1,clk,1'b0,e2_2);
    dff df24[22:0](m1_1,clk,1'b0,m1_2);
    dff df25[22:0](m2_1,clk,1'b0,m2_2);
    dff df26[31:0](a_1,clk,1'b0,a_2);
    dff df27[31:0](b_1,clk,1'b0,b_2);

    // exponent and mantissa  ------ level 3 --------

    wire [64:0] product;
    wire [31:0] ip1,ip2;
    assign ip1 = {8'b00000000,|e1_2,m1_2};
    assign ip2 = {8'b00000000,|e2_2,m2_2};

    WM wm1 (ip1,ip2,clk,product); //8 clk delay
    wire sign_1_s;
    wire [31:0] a_2_s,b_2_s;
    wire [7:0] e1_2_s,e2_2_s;
    synchronize sy1 (sign_1_s,a_2_s,b_2_s,e1_2_s,e2_2_s,sign_1,a_2,b_2,e1_2,e2_2,clk);


    assign exponent = product[47] ? e1_2_s + e2_2_s - 126 : e1_2_s + e2_2_s - 127;
    assign mantissa = product[47] ? product[46:24] : product[45:23];

    dff df31(sign_1_s,clk,1'b0,sign_2);
    dff df32[7:0](exponent,clk,1'b0,exponent_1);
    dff df33[22:0](mantissa,clk,1'b0,mantissa_1);
    dff df34[31:0](a_2_s,clk,1'b0,a_3);
    dff df35[31:0](b_2_s,clk,1'b0,b_3);

    //final output 

    wire isnan,isinf,inzero;
    is_nan in1 (isnan,a_3,b_3);
    is_inf if1 (isinf,a_3,b_3,isnan);
    is_zero iz1 (iszero,a_3,b_3);

    //assign out = {sign_2,exponent_1,mantissa_1};
    assign out = isnan ? 32'b01111111100000000000000000000001:(isinf ? 32'b01111111100000000000000000000000: (iszero ? 32'b0 : {sign_2,exponent_1,mantissa_1}));
endmodule

module tb;

reg [31:0] a,b;
wire isinf,isnan,iszero;
wire[31:0] out;
reg clk;


multiplier m1 (out,a,b,clk);

always
begin
    #5 clk = ~clk;
end
initial 
begin
    clk = 0;
    a = 32'b00000000000000000000000000000000; //zero
    b = 32'b01000000101000000000000000000000;

    #10 b = 32'b01111111100000000000000000000001; //nan

    #10 b = 32'b01111111100000000000000000000000; //inf

    #10 a = 32'b00111111100111011111001110110110; //1.234
        b = 32'b11000100011110100000000000000000; //-1000
        
    #10 a = 32'b01000000101000000000000000000000; //5
        b = 32'b01000000100000000000000000000000; //4
    #200 $finish;
end
initial
    $monitor($time," a = %b ; b = %b ; out = %b ;",a,b,out);

endmodule