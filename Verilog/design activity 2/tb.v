`include "cla_gpk_16.v"
module top;
  wire [16:0] sum;
 
  reg [15:0] a, b;
  
  integer i=0;
  sixteenTwoBitAdder d1(sum[16:0], a[15:0], b[15:0]);
  
  initial
  begin
    $display("input 1     input 2         sum ");
  end
  

  initial
  begin
    a=16'b0010000000000001; b=16'b0001000000000001;
    #100  a=16'b0000000000000010; b=16'b0000000000000010;
    #100  a=16'b0000000000000110; b=16'b0000000000000010;


  end
 
  initial
    begin
        $monitor("%d      %d       %d  ", a[15:0], b[15:0], sum[16:0]);
  
    end
    

  
endmodule
