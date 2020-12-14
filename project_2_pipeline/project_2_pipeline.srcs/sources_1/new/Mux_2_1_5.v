`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 15:27:25
// Design Name: 
// Module Name: MUX2_1_5
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


module MUX2_1_5(
input selection,
input [4:0] input1,input2,
output reg [4:0] out
    );
    always@(*)begin
    if(selection==1) out=input2;
    else out=input1;
    end
endmodule
