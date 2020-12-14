`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 01:31:19
// Design Name: 
// Module Name: MUX2_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Mux_2_1_32(
input selection,
input [31:0] input1,input2,
output reg [31:0] out
    );
    always@(*)begin
    if(selection==1) out=input2;
    else out=input1;
    end
endmodule
