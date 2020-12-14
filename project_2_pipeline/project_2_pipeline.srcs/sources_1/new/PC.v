`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 11:32:10
// Design Name: 
// Module Name: PC
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


module PC (
	input clk, PCWrite,
	input [31:0] pc_in,
	output reg [31:0] pc_out	
);

	initial begin
		pc_out = 32'b0;
	end

	always @(posedge clk) begin 
		if (PCWrite)  pc_out <= pc_in;
	end

endmodule