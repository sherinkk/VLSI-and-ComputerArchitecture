`include "BS.v"

module top;

wire [23:0] c;
reg [23:0] a;
reg[7:0] b;

BarrelShift bs1 (a[23:0],b[7:0],c[23:0]);

initial
begin
    $display("input 1                  input 2                    sum ");
end


initial
begin
    a=23'b10000000000000000000000; b=8'b00000100;
    #100  b=8'b00000010;
 
end
initial
    begin
        $monitor("%b      %d       %b  ", a[23:0], b[7:0], c[23:0]);
  
    end

endmodule 