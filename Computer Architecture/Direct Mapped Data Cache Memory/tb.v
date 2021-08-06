`include "code.v"

module top ();
	reg [16:0] r_addr, w_addr; reg [31:0] w_data; reg clk; reg r_enable, w_enable; wire [31:0] r_data;
	dcache C1 (r_addr, w_addr, w_data, r_enable, w_enable, clk,r_data);

	initial begin
		clk = 0;
		forever begin
			#1 clk = ~clk;
		end
	end

	initial begin

		#5 r_enable = 1'b1;
		r_addr = 17'b100_1110000000_1011;
		#5 r_enable = 1'b0;
		#5$display("%d %b: %h\n", $time, r_addr, r_data);


		#5 w_enable = 1'b1;
		w_addr = 17'b100_1110000000_1011;
		w_data = 32'h00000ccc;
		#5 w_enable = 1'b0;
        $display("\n");

		#5 r_enable = 1'b1;
		r_addr = 17'b100_1110000000_1011;
		#5 r_enable = 1'b0;
		#5 $display("%d %b: %h\n", $time, r_addr, r_data);



		
		#100 $finish;
	end

endmodule