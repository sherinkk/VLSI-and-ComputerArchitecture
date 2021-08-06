module BarrelShift(input [23:0]A, input [7:0]shift, output [23:0]B);
    assign B = A>>shift;
endmodule