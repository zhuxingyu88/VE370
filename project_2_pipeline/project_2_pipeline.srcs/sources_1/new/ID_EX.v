`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 22:13:20
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(
    input clk,
    input Flush,
    input ID_RegWrite,
    output reg EX_RegWrite,
    input ID_MemtoReg,
    output reg EX_MemtoReg,
    input ID_MemWrite,
    output reg EX_MemWrite,
    input ID_MemRead,
    output reg EX_MemRead,
    input [1:0] ID_ALUOp,
    output reg [1:0] EX_ALUOp,
    input ID_RegDst,
    output reg EX_RegDst,
    input ID_ALUSrc,
    output reg EX_ALUSrc,
    input [31:0] ID_RegData1,
    input [31:0] ID_RegData2,
    output reg [31:0] EX_RegData1,
    output reg [31:0] EX_RegData2,
    input [31:0] ID_SignExImm,
    output reg [31:0] EX_SignExImm,
    input [4:0] ID_Rs,
    output reg [4:0] EX_Rs,
    input [4:0] ID_Rt,
    output reg [4:0] EX_Rt,
    input [4:0] ID_Rd,
    output reg [4:0] EX_Rd
    );
    
    initial begin
            EX_RegWrite = 1'b0;
            EX_MemtoReg = 1'b0;
            EX_MemWrite = 1'b0;
            EX_MemRead = 1'b0;
            EX_ALUOp = 2'b0;
            EX_RegDst = 1'b0;
            EX_ALUSrc = 1'b0;
            EX_RegData1 = 32'b0;
            EX_RegData2 = 32'b0;
            EX_SignExImm = 32'b0;
            EX_Rs = 5'b0;
            EX_Rt = 5'b0;
            EX_Rd = 5'b0;
        end
    
        always @ (posedge clk) begin
            if (Flush) begin
                EX_RegWrite <= 1'b0;
                EX_MemtoReg <= 1'b0;
                EX_MemWrite <= 1'b0;
                EX_MemRead <= 1'b0;
                EX_ALUOp <= 2'b0;
                EX_RegDst <= 1'b0;
                EX_ALUSrc <= 1'b0;
            end
            else begin
                EX_RegWrite <= ID_RegWrite;
                EX_MemtoReg <= ID_MemtoReg;
                EX_MemWrite <= ID_MemWrite;
                EX_MemRead <= ID_MemRead;
                EX_ALUOp <= ID_ALUOp;
                EX_RegDst <= ID_RegDst;
                EX_ALUSrc <= ID_ALUSrc;
                EX_RegData1 <= ID_RegData1;
                EX_RegData2 <= ID_RegData2;
                EX_SignExImm <= ID_SignExImm;
                EX_Rs <= ID_Rs;
                EX_Rt <= ID_Rt;
                EX_Rd <= ID_Rd;
            end
        end
    
endmodule
