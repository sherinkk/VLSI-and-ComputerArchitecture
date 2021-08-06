`include "splitter.v"
`include "findMantissa.v"
`include "BS.v"

module adder(a,b,out);

input [31:0] a,b;
output [31:0] out;



//finding the larger number [in terms of magnitude]
reg [31:0] n1,n2;

always @(a or b)
begin
    if(a[30:0]>b[30:0])
    begin
        n1 = a;
        n2 = b;

    end
    else
    begin
        n1 = b;
        n2 = a;
    end
end

//assign sign of output as the same as the sign of the larger number
assign out[31] = n1[31];


//splitting to sign, exponent, mantissa
wire s1,s2;
wire [7:0] e1,e2;
wire [22:0] m1,m2;

splitter split1 (n1,s1,e1,m1);
splitter split2 (n2,s2,e2,m2);




//shifting mantissa of smaller number to make its exponent value the same as that of the larger number & then adding the mantissas
wire [7:0] e_diff;
assign e_diff = e1 - e2;

wire [23:0]m2_23,m1_23,m2_shift,m2_correct;
assign m2_23[23] = 1'b1;
assign m1_23[23] = 1'b1;
assign m2_23[22:0] = m2[22:0];
assign m1_23[22:0] = m1[22:0];


//shifting
BarrelShift bs2 (m2_23,e_diff,m2_shift);


//calculating sum of the mantissas
wire [23:0]sum;
wire carry;

assign m2_correct = {32{s1^s2}}^m2_shift;//taking 1s complement if needed
reg[23:0] m2_final;

always @(m2_correct)
begin
    if(s1^s2 == 1'b1)
    begin
        m2_final[23:0] = m2_correct + 1'b1;//taking 2s if needed
    end
    else if(s1^s2 == 1'b0)
    begin
        m2_final[23:0] = m2_correct;
    end
end


find_mantissa fm1 (sum,carry,m1_23,m2_final,s1^s2);

reg [22:0] mantissa,xy;
reg [7:0] exponent;

integer j;

//normalising
always @(sum)
begin
    if(carry == 1'b1)
    begin
        mantissa[22:0] = sum[23:1];
        exponent = e1 + 1'b1;
        if(exponent == 8'b00000000)
        begin
            exponent = e1;
        end

    end
    else if(sum[23]==1'b0)
    begin
        j=1;
        while (sum[23-j]==1'b0)
        begin
            j=j+1;
        end
        exponent = e1 - j;

        xy=sum[22:0];

        if(j==24)
        begin
            exponent = 8'b0;
        end
        mantissa[22:0] = xy<<j;

        
    end
    else if(sum[23] == 1'b1)
    begin
        mantissa[22:0] = sum[22:0];
        exponent = e1;
    end
end



assign out[30:23] = exponent;
assign out[22:0] = mantissa[22:0];




endmodule
