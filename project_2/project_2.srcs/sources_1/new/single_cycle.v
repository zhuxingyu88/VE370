`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 11:32:10
// Design Name: 
// Module Name: single_cycle
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


module single_cycle(input clk);
    
    wire [31:0] PC_in, PC_out, Instuction, Jump_addr, PC_plus_four, Jump_mux_0;
    
    wire RegDst, Jump, Branch, MemRead, MemtoReg, RegWrite, ALUSrc, MemWrite;
    wire [1:0] ALUOp;
    
    // register
    wire [4:0] WriteRegister;
    wire [31:0] ReadData1, ReadData2, WriteData;

    // alu
    wire zero;
    wire [31:0] ALU_b, result;
    
    // other
    wire [31:0] sign_extend_output;
    wire [31:0] data_memory_read_data;
    wire [3:0] ALU_control; 
    wire Beq, Bne;

    assign PC_plus_four = PC_out + 4;
    assign Branch = (zero & Beq) | (~zero & Bne);
    assign Jump_addr = {PC_plus_four[31:28],Instuction[25:0],2'b0};
    
    assign WriteRegister = (RegDst == 1'b0) ? Instuction[20:16] : Instuction[15:11];
    assign ALU_b = (ALUSrc == 1'b0) ?  ReadData2 : sign_extend_output;
    assign Jump_mux_0 = (Branch == 1'b0) ? PC_plus_four : PC_plus_four + (sign_extend_output << 2 );
    assign PC_in = (Jump == 1'b0) ? Jump_mux_0 : Jump_addr; 
    assign WriteData = (MemtoReg == 1'b0) ? result : data_memory_read_data;
    
    PC singleCycle_PC(clk, PC_in, PC_out);
    
    Instruction_Memory instructionMemory(PC_out, Instuction);
    
    Control control(Instuction[31:26], RegDst, Jump, Beq, Bne, MemRead, MemtoReg, MemWrite,ALUSrc, RegWrite, ALUOp);
     
    register regFile(clk, RegWrite, Instuction[25:21], Instuction[20:16], WriteRegister, WriteData, ReadData1, ReadData2);
    
    sign_extention signExtention(Instuction[15:0], sign_extend_output);
    
    ALUControl alucontrol(ALUOp, Instuction[5:0], ALU_control);
    
    ALU alu(ALU_control, ReadData1, ALU_b, zero, result);
    
    data_memory dataMemory(clk, result, ReadData2, MemRead, MemWrite, data_memory_read_data);

endmodule
