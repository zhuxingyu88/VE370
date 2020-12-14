`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/23 10:34:37
// Design Name: 
// Module Name: main_memory
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


module main_memory(
    input write,
    input [9:0] address,
    input [127:0] write_data,
    output reg [127:0] read_data
    );
    reg [31:0] memory [255:0];
    integer i;
    
    initial begin
    for(i = 0; i < 256; i = i + 1)
        memory[i] = 32'b0;
    end
    
    always @(write) begin
        if (write) begin
            memory[{address[9:4],2'b00}] = write_data[127:96];
            memory[{address[9:4],2'b01}] = write_data[95:64];
            memory[{address[9:4],2'b10}] = write_data[63:32];
            memory[{address[9:4],2'b11}] = write_data[31:0];
            read_data = 0;
        end
        else begin
            read_data = {memory[{address[9:4],2'b11}], memory[{address[9:4],2'b10}], memory[{address[9:4],2'b01}], memory[{address[9:4],2'b00}]};
        end
     end
    
endmodule
