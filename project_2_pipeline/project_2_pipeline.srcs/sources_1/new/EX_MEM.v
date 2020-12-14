`timescale 1ns / 1ps

module EX_MEM(
    input clk,
    input EX_RegWrite,
    output reg MEM_RegWrite,
    input EX_MemtoReg,
    output reg MEM_MemtoReg,
    input EX_MemWrite,
    output reg MEM_MemWrite,
    input EX_MemRead,
    output reg MEM_MemRead,
    input [31:0] EX_ALUResult,
    output reg [31:0] MEM_ALUResult,
    input [31:0] EX_RegData2,
    output reg [31:0] MEM_RegData2,
    input [4:0] EX_RegisterRd,
    output reg [4:0] MEM_RegisterRd
    );
    
    initial begin
        MEM_ALUResult = 32'b0;
        MEM_RegData2 = 32'b0;
        MEM_MemWrite = 1'b0;
        MEM_MemRead = 1'b0;
        MEM_RegWrite = 1'b0;
        MEM_MemtoReg = 1'b0;
        MEM_RegisterRd = 5'b0;
    end
    
    always @ (posedge clk) begin
        MEM_ALUResult <= EX_ALUResult;
        MEM_RegData2 <= EX_RegData2;
        MEM_MemWrite <= EX_MemWrite;
        MEM_MemRead <= EX_MemRead;
        MEM_RegWrite <= EX_RegWrite;
        MEM_MemtoReg <= EX_MemtoReg;
        MEM_RegisterRd <= EX_RegisterRd;
    end
    
endmodule