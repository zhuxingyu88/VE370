`timescale 1ns / 1ps

module counter_ring_4 (clk, AN); 
input clk; 
output [3:0] AN; 
reg [3:0] AN = 4'b1110; 
always @ (posedge clk)
begin
    AN[0] <= AN[1];
    AN[1] <= AN[2];
    AN[2] <= AN[3];
    AN[3] <= AN[0];
end
endmodule 