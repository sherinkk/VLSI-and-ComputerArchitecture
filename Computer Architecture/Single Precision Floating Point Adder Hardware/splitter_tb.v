`include "splitter.v"
module top;

reg [31:0] a;
wire s;
wire [7:0] e;
wire [22:0] m;

splitter s_1 (a,s,e,m);

initial 
begin
    a = 32'b10000000100000000000000000000000;
    #10 a=32'b10000000100000000000000000000001;
end

initial
    $monitor($time," a = %b; sign = %b; exponent = %b; mantissa = %b;",a,s,e,m);
endmodule
