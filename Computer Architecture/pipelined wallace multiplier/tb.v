`include "multiplier.v"
module tb();

    wire [64:0] out;
	reg [31:0] a,b;
    reg clk;

    WM m1 (a,b,clk,out);

    always 
    begin

        #5 clk = ~clk;
    end
	initial 
		begin
            clk=1;

			a=32'b00000000000000000000000000000010;
			b=32'b11011110111111101111111011111110;
			#10 a = 32'b00000000000000000000000000000001;
			#10 a = 32'b00000000000000000000000000000000;

            #100 $finish;

		end
	
	initial
		begin
			$monitor($time," %b %d  %d  %d\n",clk,a,b,out);
		end

endmodule