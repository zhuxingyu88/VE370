`timescale 1ns / 1ps

module Mux_3_1_32bit(out, in0, in1, in2, sel);
    parameter size = 32;
    
    input [1:0] sel;
    input [size-1:0] in0, in1, in2;
    output [size-1:0] out;
    
    reg [size-1:0] out;
    
    always@(*)
    begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            default out = 0;
        endcase
    end
endmodule
