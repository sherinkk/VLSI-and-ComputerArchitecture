module regfile(input clk,input rst,input w_enable,input[4:0] w_addr,input [31:0] w_data,input [4:0] r_addr1,input[4:0] r_addr2,output[31:0] out_data1,output[31:0] out_data2);

reg [31:0] registers[31:0];
reg [31:0] r_data1,r_data2;

integer i;

always @(posedge clk)
begin
	if(rst == 1'b0)
	begin
		for(i=0;i<32;i++)
			registers[i] <= 32'b0;
	end

	registers[w_addr] <= (w_enable && rst)?w_data:registers[w_addr];
	r_data1 <= w_enable?r_data1:registers[r_addr1];
	r_data2 <= w_enable?r_data2:registers[r_addr2];	

    
end

assign out_data1 = w_enable ? 8'bz : r_data1;
assign out_data2 = w_enable ? 8'bz : r_data2;

endmodule


module top;

reg clk,w_enable,rst;
reg [4:0] w_addr,r_addr1,r_addr2;
reg [31:0] w_data;
wire [31:0] out_data1,out_data2;

regfile rf1 (clk,rst,w_enable,w_addr,w_data,r_addr1,r_addr2,out_data1,out_data2);

always
begin
    #5 clk = ~clk;
end

integer i;

initial
begin
	clk = 1;rst = 0;w_enable = 0;
	
	#10 r_addr1 = 10; r_addr2 = 2;

	#10 rst=1;w_enable = 1;w_addr = 10;w_data = 1000;

    #10 w_addr = 20;w_data = 2000;

    #10 w_addr = 15; w_data = 3000;

    #10 w_addr = 30; w_data = 6000;

    #10 w_enable = 0; r_addr1 = 10; r_addr2 = 20;

    #10 r_addr1 = 15; r_addr2 = 30;

    #10 $finish;
end           

initial
    $monitor($time,"\n\nw_enable=%d; reset=%d;\n\nw_addr=%d;  w_data=%d;\n\nr_addr1=%d; out_data1=%d;\nr_addr2=%d; out_data2=%d;\n-----------------------------\n",w_enable,rst,w_addr,w_data,r_addr1,out_data1,r_addr2,out_data2);


endmodule
