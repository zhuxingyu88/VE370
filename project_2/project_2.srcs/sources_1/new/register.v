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



module register (
	input clk, RegWrite,
	input [4:0] ReadReg1, ReadReg2, WriteReg,
	input	[31:0]	WriteData,
	output	[31:0]	ReadData1, ReadData2
);

	reg [31:0] 	register_file [31:0];
	integer i;
	
	initial begin
		for(i = 0 ; i < 32;i = i+1) begin
			register_file[i] = 32'b0;
		end
	end
    // read data
	assign ReadData1 = register_file[ReadReg1];
	assign ReadData2 = register_file[ReadReg2];
	// write data
	always @(negedge clk ) begin
		if(RegWrite == 1'b1) begin
			 register_file[WriteReg] <= WriteData;
		end
	end

endmodule