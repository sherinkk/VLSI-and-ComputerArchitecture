module PP(a,b,pp);

input [31:0] a,b;
output reg [31:0][63:0] pp;

integer i;

always@(a or b)
begin
	for(i=0;i<32;i++)
		begin
			pp[i]=a&{32{b[i]}};
			pp[i]=pp[i]<<i;
		end
end

endmodule
		

