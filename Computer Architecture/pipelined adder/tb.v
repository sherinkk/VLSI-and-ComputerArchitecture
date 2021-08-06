`include "adder.v"
module tb();

    wire [31:0] gpk_1,carry,i_sum;wire[32:0]f_sum;
	reg [31:0] a,b;
    reg clk;

	wire out;
	
	isum isum1[31:0](i_sum, a, b);   //initial sum - xor of the two inputs
	
	igpk igpk1[31:0](gpk_1, a, b);	//labelling the bits of 'gpk_1' as generate(g),propogate(g) or kill(k)
	carryAndOutFinder cF1 (f_sum,gpk_1,i_sum,clk);  //finding carry from 'gpk_1' and then final sum (xor of initial sum and carry) 
	


    always 
    begin

        #5 clk = ~clk;
    end
	initial 
		begin
            clk=1;

			a=32'b00000001000000010000000100000001;
			b=32'b11011110111111101111111011111110;
			#10 a = 32'b00000000000000000000000000000000;
			   b = 32'b00000000000000000000000000000001;
			#10 a = 32'b11000000000000000000000000000000;
				b = 32'b10000000000000000000000000000000;
			#10 a = 32'b110100000000000000000000;
				b = 32'b110000000000000000000000;
            #75 $finish;

		end
	
	initial
		begin
			$monitor($time," %d  %d + %d  =  %d\n",clk,a,b,f_sum);
		end

endmodule