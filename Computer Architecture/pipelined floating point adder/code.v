`include "splitter.v"
`include "findMantissa.v"
`include "synchronize.v"

module adder(out,a,b,clk);

    input [31:0] a,b;
    input clk;
    output [31:0] out;


    //finding the larger number in terms of magnitude ----- level 1 ------
    wire [31:0] n1,n2,n1_1,n2_1,n1_2,n2_2;

    assign n1 = (a[30:0]>b[30:0]) ? a : b;
    assign n2 = (a[30:0]>b[30:0]) ? b : a;

    dff df10[31:0](n1,clk,1'b0,n1_1);
    dff df11[31:0](n2,clk,1'b0,n2_1);



    //splitting  ----- level 2 --------

    wire s1,s2,s1_2,s2_2,s1_3,s2_3,s1_4,s2_4;
    wire [7:0] e1,e2,e1_2,e2_2,e1_3,e2_3,e1_4,e2_4;
    wire [22:0] m1,m2,m1_2,m2_2,m1_3,m2_3,m1_4,m2_4;

    splitter split1 (n1_1,s1,e1,m1);
    splitter split2 (n2_1,s2,e2,m2);

    dff df20(s1,clk,1'b0,s1_2);
    dff df21(s2,clk,1'b0,s2_2);
    dff df22[7:0](e1,clk,1'b0,e1_2);
    dff df23[7:0](e2,clk,1'b0,e2_2);
    dff df24[22:0](m1,clk,1'b0,m1_2);
    dff df25[22:0](m2,clk,1'b0,m2_2);

    //shifting the mantissas   ----- level 3 --------
    wire [7:0] e_diff;
    assign e_diff = e1_2 - e2_2;

    wire [23:0]m2_23,  m1_23,m1_23_3,  m2_shift,m2_shift_3,  m2_correct;
    assign m2_23[23] = |e2_2;
    assign m1_23[23] = |e1_2;
    assign m2_23[22:0] = m2_2[22:0];
    assign m1_23[22:0] = m1_2[22:0];

    BarrelShift bs2 (m2_23,e_diff,m2_shift);



    dff df30(s1_2,clk,1'b0,s1_3);
    dff df31(s2_2,clk,1'b0,s2_3);
    dff df32[7:0](e1_2,clk,1'b0,e1_3);
    dff df33[7:0](e2_2,clk,1'b0,e2_3);
    dff df34[23:0](m1_23,clk,1'b0,m1_23_3);
    dff df35[23:0](m2_shift,clk,1'b0,m2_shift_3);


    //sum of mantissas   ----- level 4 --------
    wire [23:0]sum,sum_4;
    wire carry,carry_4,carry_44;

    assign m2_correct = {32{s1_3^s2_3}}^m2_shift_3;//taking 1s complement if needed
    wire[23:0] m2_final;

    assign m2_final = (s1_3^s2_3) ? m2_correct + 1'b1: m2_correct;//taking 2s if needed

    find_mantissa fm1 (sum,carry,m1_23_3,m2_final,s1_3^s2_3,clk);
    wire s1_3_t,s2_3_t;
    wire [7:0] e1_3_t,e2_3_t;
    synchronize a1(s1_3_t,s2_3_t,e1_3_t,e2_3_t,s1_3,s2_3,e1_3,e2_3,clk);

    dff df40(s1_3_t,clk,1'b0,s1_4);
    dff df41(s2_3_t,clk,1'b0,s2_4);
    dff df42[7:0](e1_3_t,clk,1'b0,e1_4);
    dff df43[7:0](e2_3_t,clk,1'b0,e2_4);
    dff df44[23:0](sum,clk,1'b0,sum_4);
    dff df45(carry,clk,1'b0,carry_4);
   //dff df46(carry_44,clk,1'b0,carry_4);


    //final op   ----- level 5 ---------
    reg[22:0] mantissa,xy;
    reg[7:0] exponent;
    reg sign;

    integer j;



    always @(*)
    begin
        if(carry_4 == 1'b1)
        begin
            mantissa[22:0] = sum_4[23:1];
            exponent = e1_4 + 1'b1;
            if(exponent == 8'b00000000)
            begin
                exponent = e1_4;
            end
            sign = s1_4^s2_4;
        end
        else 
        begin
            j=0;
            while (sum_4[23-j]==1'b0)
            begin
                j=j+1;
            end
            exponent = e1_4 - j;
            xy=sum_4[22:0];
            
            if(j==24)
            begin
                exponent = 8'b0;
            end
            mantissa[22:0] = xy<<j; 
            sign = s1_4^s2_4;
        end
    end

    wire [22:0] man,man_f;
    wire [7:0] exp,exp_f;
    wire sn,sn_f;

    assign sn = sign;
    assign exp = exponent;
    assign man = mantissa;

    dff df51(sn,clk,1'b0,sn_f);
    dff df52[7:0](exp,clk,1'b0,exp_f);
    dff df53[22:0](man,clk,1'b0,man_f);

    assign  out = {sn_f,exp_f,man_f};

    

endmodule



module tb;

reg [31:0] a,b;
wire [31:0] out;
reg clk;
adder ad1 (out,a,b,clk);

always 
begin
    #5 clk = ~clk;    
end
initial
begin
    clk = 1'b0;
    a = 32'b01000011000000100000000000000000; //130
    b = 32'b00000000000000000000000000000000; //zero

    #10 a = 32'b01111111100000000000000000000000; //inf
        b = 32'b01110000000000000000000000000000;

    #10 a = 32'b01000001011100000000000000000000; //15
        b = 32'b11000100011110100000000000000000; //-1000

    #10 a = 32'b01111111100000000000000000000001; //nan
        b = 32'b01110000000000000000000000000000;

    #10 a = 32'b01000001010100000000000000000000; //13
        b = 32'b01000001010000000000000000000000; //12



    #200 $finish;
end

initial
    $monitor($time,"a = %b ; b = %b ; out = %b ;",a,b,out);


endmodule