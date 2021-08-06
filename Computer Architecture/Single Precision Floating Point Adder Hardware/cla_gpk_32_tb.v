`include "cla_gpk_32.v"
module top;
  wire [32:0] sum;
 
  reg [31:0] a, b;
  
  integer i=0;
  thirtyTwoBitAdder d1(sum[32:0], a[31:0], b[31:0]);
  
  initial
  begin
    $display("input 1                  input 2                    sum ");
  end
  

  initial
  begin
    a=32'b00000000000000000000000000000000; b=32'b00000000000000010001000000000001;
    #100  a=32'b00000000000000100001000000000001; b=32'b00000000000000100001000000000001;
 

  end
 
  initial
    begin
        $monitor("%d      %d       %d  ", a[31:0], b[31:0], sum[32:0]);
  
    end
    

  
endmodule