`timescale 1ns / 1ps

module Mux_2_1_8bit(out, in0, in1, sel);
    parameter size = 8;
    
    input sel;
    input [size-1:0] in0, in1;
    output [size-1:0] out;

    assign out = (sel == 1'b0) ? in0 : in1;
endmodule
