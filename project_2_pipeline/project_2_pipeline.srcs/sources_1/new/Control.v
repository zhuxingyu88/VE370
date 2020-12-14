`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 11:32:10
// Design Name: 
// Module Name: Control
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


module Control (
    input [5:0] opcode,
    output reg RegDst, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] ALUOp
);

    initial begin
        RegDst = 1'b0;
        Jump = 1'b0;
        Beq = 1'b0;
        Bne = 1'b0;
        MemRead = 1'b0;
        MemtoReg = 1'b0;
        MemWrite = 1'b0;
        ALUSrc = 1'b0;
        RegWrite = 1'b0;
        ALUOp = 2'b00;
    end

    always @ (opcode) begin
        case (opcode)
            6'b000000: begin // R-type
                RegDst <= 1'b1;
                Jump <= 1'b0;
                Beq <= 1'b0;
                Bne <= 1'b0;
                MemRead <= 1'b0;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b0;
                RegWrite <= 1'b1;
                ALUOp <= 2'b10;
            end
            6'b000010: begin // j-type
                RegDst <= 1'b1;
                Jump <= 1'b1;
                Beq <= 1'b0;
                Bne <= 1'b0;
                MemRead <= 1'b0;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b0;
                RegWrite <= 1'b0;
                ALUOp <= 2'b10;
            end
            6'b100011: begin // lw
                RegDst <= 1'b0;
                Jump <= 1'b0;
                Beq <= 1'b0;
                Bne <= 1'b0;
                MemRead <= 1'b1;
                MemtoReg <= 1'b1;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b1;
                RegWrite <= 1'b1;
                ALUOp <= 2'b00;
            end
            6'b101011: begin // sw
                RegDst <= 1'b0;
                Jump <= 1'b0;
                Beq <= 1'b0;
                Bne <= 1'b0;
                MemRead <= 1'b0;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b1;
                ALUSrc <= 1'b1;
                RegWrite <= 1'b0;
                ALUOp <= 2'b00;
            end
            6'b000100: begin // beq
                RegDst <= 1'b1;
                Jump <= 1'b0;
                Beq <= 1'b1;
                Bne <= 1'b0;
                MemRead <= 1'b0;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b0;
                RegWrite <= 1'b0;
                ALUOp <= 2'b01;
            end
            6'b000101: begin // bne
                RegDst <= 1'b1;
                Jump <= 1'b0;
                Beq <= 1'b0;
                Bne <= 1'b1;
                MemRead <= 1'b0;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b0;
                RegWrite <= 1'b0;
                ALUOp <= 2'b01;
            end
            6'b001000: begin // addi
                RegDst <= 1'b0;
                Jump <= 1'b0;
                Beq <= 1'b0;
                Bne <= 1'b0;
                MemRead <= 1'b0;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b1;
                RegWrite <= 1'b1;
                ALUOp <= 2'b00;
            end
            6'b001100: begin // andi
                RegDst <= 1'b0;
                Jump <= 1'b0;
                Beq <= 1'b0;
                Bne <= 1'b0;
                MemRead <= 1'b0;
                MemtoReg <= 1'b0;
                MemWrite <= 1'b0;
                ALUSrc <= 1'b1;
                RegWrite <= 1'b1;
                ALUOp <= 2'b11;
            end
            default: begin
                RegDst = 1'b0;
                Jump = 1'b0;
                Beq = 1'b0;
                Bne = 1'b0;
                MemRead = 1'b0;
                MemtoReg = 1'b0;
                MemWrite = 1'b0;
                ALUSrc = 1'b0;
                RegWrite = 1'b0;
                ALUOp = 2'b00;
            end
        endcase
    end

endmodule