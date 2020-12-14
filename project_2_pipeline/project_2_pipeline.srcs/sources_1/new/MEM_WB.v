`timescale 1ns / 1ps

module MEM_WB(
    input clk,
    input MEM_RegWrite,
    input MEM_MemtoReg,
    input [4:0] MEM_Rd,
    input [31:0] MEM_Memory,
    input [31:0] MEM_ALUResult,
    output reg WB_RegWrite,
    output reg WB_MemtoReg,
    output reg [4:0] WB_Rd,
    output reg [31:0] WB_Memory,
    output reg [31:0] WB_ALUResult 
    );
    
    initial begin
        WB_RegWrite = 1'b0;
        WB_MemtoReg = 1'b0; 
        WB_Rd = 5'b0;
        WB_Memory = 32'b0;
        WB_ALUResult = 32'b0;
    end
    
    always @ (posedge clk) begin
        WB_RegWrite <= MEM_RegWrite;
        WB_MemtoReg <= MEM_MemtoReg;
        WB_Rd <= MEM_Rd;
        WB_Memory <= MEM_Memory;
        WB_ALUResult <= MEM_ALUResult;
    end
    
endmodule