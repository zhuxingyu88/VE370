`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 11:32:10
// Design Name: 
// Module Name: sign_extention
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


module Instruction_Memory (
	input [31:0] address,
	output [31:0] instruction
);

	parameter size = 64;
	reg	[31:0] memory [size - 1:0];
	integer i;

	initial begin
		for(i = 0 ; i<size;i=i+1) begin
			memory[i] = 32'b0;
		end
		`include "D:\ji\20 Fall\ve370\project_2\my_test.txt"
	end

	assign instruction = memory[address >> 2];
endmodule