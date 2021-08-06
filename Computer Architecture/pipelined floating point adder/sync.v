module _dff_(d,clk,clear,q); 

input d, clk, clear; 
output reg q; 


always@(posedge clk) 
begin
    if(clear== 1)
        q <= 0;
    else 
        q <= d;
end 
endmodule

module sync (output i_o,input i,input clk);

    wire i_1,i_2,i_3,i_4,i_5,i_6,i_o;

    _dff_ d1(i,clk,1'b0,i_1);
    _dff_ d2(i_1,clk,1'b0,i_2);
    _dff_ d3(i_2,clk,1'b0,i_3);
    _dff_ d4(i_3,clk,1'b0,i_4);
    _dff_ d5(i_4,clk,1'b0,i_5);
    _dff_ d6(i_5,clk,1'b0,i_6);
    _dff_ d7(i_6,clk,1'b0,i_o);

endmodule