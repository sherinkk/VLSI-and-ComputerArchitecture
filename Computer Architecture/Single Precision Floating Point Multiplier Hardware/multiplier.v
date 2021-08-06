`include "splitter.v"
`include "findSign.v"
`include "WM.v"

module multiplier(input [31:0]a,input[31:0] b,output [31:0] out);

wire s1,s2;
wire [7:0] e1,e2,bias;
wire [22:0] m1,m2;

assign bias = 8'b01111111;

splitter sp1 (a,s1,e1,m1);
splitter sp2 (b,s2,e2,m2);

reg[7:0] exponent;
reg sign;
reg[22:0] mantissa;
reg [7:0] exp_final;

//if any number is infinity
always @(e1 or e2)
if(&e1 == 1 || &e2 == 1)
begin
    exp_final = 8'b11111111;
    sign = 0;
    mantissa = 0;    
end

// if any number is zero
always @(e1 or e2)
if((|e1 == 0 && |m1 == 0) || (|e2 == 0 &&  |m2 == 0))
begin
    exp_final = 0;
    sign = 0;
    mantissa = 0;    
end


//normal case

//finding sign
wire sign_t;
findSign fs1 (sign_t,s1,s2);
always@(sign_t)
begin
    sign = sign_t;
end

//finding exponent
wire [7:0] exponent_t;

assign exponent_t = e1 + e2 - bias;


always@(exponent_t or e1 or e2)
begin
    if((|e1 != 0 || |m1 !=0) && (|e2 != 0 || |m1!=0) && &e1 != 1 && &e2 != 1)
    begin
        exponent = exponent_t;
    end
    
end


//finding mantissa
reg[64:0] xy;
wire [64:0] product;
wire [31:0] ip1,ip2;
assign ip1 = {|e1,m1};
assign ip2 = {|e2,m2};


WM wm1 (ip1,ip2,product);



integer j,i;
always @(product or e1 or e2)
begin
    
    if((|e1 != 0 || |m1 !=0) && (|e2 != 0 || |m1!=0)&&   &e1 != 1    &&    &e2 != 1)
    begin
        if(product[47]==1'b1)         //incase of overflow
        begin
            
            
            exp_final = exponent +  1;
          
            mantissa = product[46:24];
            
        end
        else if(product[46] == 1'b1)
        begin
            exp_final = exponent;
            mantissa = product[45:23];
        end
        else                       // normalising the output
        begin
            j=1;i=0;
            while(product[46-j]==1'b0)
            begin
                
                j = j + 1;
                if(j<=exponent) //exponent should not go below zero..If it goes, final answer should be in denormalized form
                begin
                    i = j;
                end
            end
            
          
            
            exp_final = exponent-i;
            
            
            xy = product<<i;
            mantissa = xy[45:23];
        end
    end
    
end

assign out[31] = sign;
assign out[30:23] = exp_final;
assign out[22:0] = mantissa;



endmodule




// TEST BENCH
module top;

reg [31:0] a,b;
wire [7:0] e;wire s;wire[22:0] m;
wire [31:0] out;
wire sign;


multiplier mul (a,b,out);
initial
begin
    a = 32'b01000001001000000000000000000000; //10
    b = 32'b01000001000000000000000000000000; //8

    #10 b = 32'b00000000000000000000000000000000; //0

    #10 b = 32'b11111111100000000000000000000000; //inf

    #10 a = 32'b00111111100111011111001110110110; //1.2339
        b = 32'b01000100011110100000000000000000; //1000

    #10 a = 32'b10111111101000000000000000000000; //-1.25
        b = 32'b01000000101000000000000000000000; //5

    #10 a = 32'b00000000000000000000000001000000;// denormal 8.96831017168e-44
        b = 32'b01000100011110100000000000000000;//1000

    #10 a = 32'b00000000000000000000000000000001;//denormal 1.40129846432e-45 
        b = 32'b00111111100000000000000000000000;//1
    
end

initial
    $monitor($time,"a = %b; b = %b; out = %b ;",a,b,out);
endmodule