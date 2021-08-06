module dcache (
	input [16:0] raddr,
	input [16:0] waddr,
	input [31:0] wdata,
	input r_enable,
	input w_enable,
	input clk,
	output reg [31:0] rdata
);
	reg [31:0] m_memory [8191:0][15:0];
	reg [31:0] cache [1023:0][15:0];



	reg val [1023:0];	
	reg dirty [1023:0];
    reg [2:0] tags [1023:0];


	wire [2:0] write_tag;
	wire [9:0] write_line; 
	wire [3:0] write_offset;

	wire [2:0] read_tag;
	wire [9:0] read_line; 
	wire [3:0] read_offset;

	assign read_tag = raddr[16:14];
	assign read_line = raddr[13:4];
	assign read_offset = raddr[3:0];

	assign write_tag = waddr[16:14];
	assign write_line = waddr[13:4];
	assign write_offset = waddr[3:0];

	integer i, j;
	initial 
	begin
        		

		for (i = 0; i < 1024; i = i + 1) 
		begin
			val[i] = 0;
			dirty[i] = 0;
		end

		for (i = 0; i < 8192; i = i + 1) 
		begin
			for (j = 0; j < 16; j = j + 1) 
			begin
				m_memory[i][j] = 0; 
			end
		end

	end
	
	always @(posedge clk) 
	begin
		if (r_enable) 
		begin

			if (tags[read_line] == read_tag && val[read_line] == 1'b1) 
			begin
				$monitor("%d CACHE HIT ", $time);
				rdata = cache[read_line][read_offset];
			end 

			else 
			begin
				$display("%d CACHE MISS ", $time);

				if (dirty[write_line] == 1'b1) 
				begin

					$display("%d DIRTY LINE", $time);
					for(i=0; i < 16; i = i+1)
					begin
						m_memory[{tags[read_line], read_line}][i] = cache[read_line][i];
					end
					dirty[read_line] = 1'b0;
				end

				else 
				begin

					$display("%d COPYING FROM MEM TO CACHE ", $time);
					for(i=0; i < 16; i = i+1)
					begin
						cache[read_line][i] = m_memory[{read_tag, read_line}][i];
					end	
					val[read_line] = 1'b1;
					tags[read_line] = read_tag;
				end
			end
		end

		if (w_enable) 
		begin

			if (tags[write_line] == write_tag && val[write_line] == 1'b1) 
			begin
				$display("%d CACHE HIT ", $time);
				cache[write_line][write_offset] = wdata;
				dirty[write_line] = 1'b1;
			end


			else 
			begin
				$display("%d CACHE MISS ", $time);
			
				if (dirty[write_line] == 1'b1) 
				begin

					$display("%d DIRTY LINE  ", $time);
					for(i=0; i < 16; i = i+1)
					begin
						m_memory[{tags[write_line], write_line}][i] = cache[write_line][i];
					end	
					dirty[write_line] = 1'b0;
				end
				
				else 
				begin

					$display("%d COPYING FROM MEM TO CACHE ", $time);
					for(i=0; i < 16; i = i+1)
					begin
						cache[write_line][i] = m_memory[{write_tag, write_line}][i];
					end				
					val[write_line] = 1'b1;
					tags[write_line] = write_tag;
				end
			end
		end
	end

endmodule