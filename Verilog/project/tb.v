`include "dadda.v"
module top;
  wire [32:0] sum;
 
  reg [15:0] a, b;
  
  integer i=0;
  dadda d1(sum[32:0], a[15:0], b[15:0]);
  
  initial
  begin
    $display("input 1     input 2         product");
  end
  

  initial
  begin
    a=16'b0000000000000001; b=16'b0000000000000001;
    #100  a=16'b0000000000000010; b=16'b0000000000000010;
    #100  a=16'b0000000000000110; b=16'b0000000000000010;


  end
 
  initial

  begin
    if (i%2==0)
    begin
        $monitor("%d      %d       %d  ", a[15:0], b[15:0], sum[32:0]);
        i=i+1;
    end
    
  end
  
endmodule