`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 11:32:10
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input clk,    
	input [31:0] address, WriteData,
	input MemRead, MemWrite,
	output [31:0] ReadData
    );
    
    parameter nums = 32;
    reg [31:0] memory [nums-1:0];
    integer i;
        
    initial begin
        for(i = 0; i < nums; i = i + 1)
            memory[i] = 32'b0;
        end
    
    always @(negedge clk) begin
        if (MemWrite == 1'b1) begin
             memory[address] = WriteData;
        end
    end
    // if !MemRead ReadData = 0
    assign ReadData = (MemRead == 1'b1) ? memory[address]:32'b0; 
    
endmodule