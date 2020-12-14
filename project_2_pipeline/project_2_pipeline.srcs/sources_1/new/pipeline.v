`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/05 21:57:45
// Design Name: 
// Module Name: pipeline
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


module pipeline(
    input clk,
    input [4:0] reg_read_index,
    output [31:0] PC_out,
    output [31:0] Reg_out
    );
    // wire
    // IF
    wire [31:0] IF_pc_in, IF_pc_out, IF_pc_plus_4, IF_instruction, IF_branchjumpaddress;
    wire write;
    // ID
    wire [31:0] ID_pc_plus_4, ID_Instruction, ID_Regdata1, ID_Regdata2, ID_branchaddress,ID_jumpaddress, ID_sign_extentedimm, ID_Regdata1final, ID_Regdata2final;
    wire ID_Branch, ID_Beq, ID_Bne, ID_RegWrite, ID_MemtoReg, ID_MemWrite, ID_MemRead, ID_RegDst, ID_ALUSrc, ID_equal, ID_Jump;
    wire [1:0] ID_ALUOp;
    // EX
    wire EX_RegWrite, EX_RegDst, EX_MemWrite, EX_MemRead, EX_MemtoReg, EX_ALUSrc, EX_Zero;
    wire [1:0] EX_ALUOp;
    wire [3:0] EX_ALU_control;
    wire [4:0] EX_Rs, EX_Rt, EX_Rd, EX_Rdestination;
    wire [5:0] EX_func;
    wire [31:0] EX_sign_extended_result, EX_Regdata1_result, EX_Regdata2_result, EX_ALU_A, EX_ALU_B_half, EX_ALU_B, EX_ALU_Result;
    // MEM
    wire [31:0] MEM_RegData2, MEM_ALUresult, MEM_Writedata, MEM_Readdata;
    wire [4:0] MEM_Rd;
    wire MEM_MemWrite, MEM_MemRead, MEM_RegWrite, MEM_MemtoReg;
    // WB
    wire wbmemread, wbregwrite, wbmemtoreg;
    wire [4:0] WB_Rd;
    wire [31:0] wbmemdata, wbALUresult, wbwritedata;
    // others
    wire [1:0] forwardingeq_control1, forwardingeq_control2;
    wire memSrc, ifidflush,idexflush;
    wire [1:0] forwardingALUin_control1, forwardingALUin_control2;
    
    assign PC_out = IF_pc_out;
    // module
    // IF
    PC pc(clk, write, IF_pc_in, IF_pc_out);
    Instruction_Memory instructionmemory(IF_pc_out, IF_instruction);
    assign IF_pc_plus_4 = IF_pc_out + 4;
    assign IF_pc_in = (ID_Branch || ID_Jump) ? IF_branchjumpaddress : IF_pc_plus_4;
        
    //ID
    Control control(ID_Instruction[31:26], ID_RegDst, ID_Jump, ID_Beq, ID_Bne, ID_MemRead, ID_MemtoReg, ID_MemWrite, ID_ALUSrc, ID_RegWrite, ID_ALUOp);
    register registerFile(.clk(clk),
                         .RegWrite(wbregwrite),
                         .ReadReg1(ID_Instruction[25:21]),
                         .ReadReg2(ID_Instruction[20:16]),
                         .WriteReg(WB_Rd),
                         .Register_in(reg_read_index),
                         .WriteData(wbwritedata),
                         .ReadData1(ID_Regdata1),
                         .ReadData2(ID_Regdata2),
                         .Register_out(Reg_out)
                         );
    sign_extention signExtention(
        .sign_in(ID_Instruction[15:0]),
        .sign_out(ID_sign_extentedimm)
        );
    Mux_3_1_32bit Mux_Equal1(
        .out(ID_Regdata1final),
        .in0(ID_Regdata1),
        .in1(wbwritedata),
        .in2(MEM_ALUresult),
        .sel(forwardingeq_control1)
        );
    Mux_3_1_32bit Mux_Equal2(
        .out(ID_Regdata2final),
        .in0(ID_Regdata2),
        .in1(wbwritedata),
        .in2(MEM_ALUresult),
        .sel(forwardingeq_control2)
        );                      
    assign ID_equal = (ID_Regdata1final==ID_Regdata2final) ? 1'b1 : 1'b0;
    assign ID_Branch = (ID_Beq && ID_equal) || (ID_Bne && !ID_equal);
    assign ID_branchaddress = ID_pc_plus_4+(ID_sign_extentedimm<<2);
    assign ID_jumpaddress = {ID_pc_plus_4[31:28], ID_Instruction[25:0], 2'b0};
    assign IF_branchjumpaddress = (ID_Branch) ? ID_branchaddress : ID_jumpaddress;
    assign ifidflush = (ID_Branch || ID_Jump) && write;
    //IFID
    IF_ID IFID(clk, write, ifidflush, IF_instruction, IF_pc_plus_4, ID_Instruction, ID_pc_plus_4);
    //IDEX
    ID_EX IDEX(
        .clk(clk),
        .Flush(idexflush),
        .ID_RegWrite(ID_RegWrite),
        .EX_RegWrite(EX_RegWrite),
        .ID_MemtoReg(ID_MemtoReg),
        .EX_MemtoReg(EX_MemtoReg),
        .ID_MemWrite(ID_MemWrite),
        .EX_MemWrite(EX_MemWrite),
        .ID_MemRead(ID_MemRead),
        .EX_MemRead(EX_MemRead),
        .ID_ALUOp(ID_ALUOp),
        .EX_ALUOp(EX_ALUOp),
        .ID_RegDst(ID_RegDst),
        .EX_RegDst(EX_RegDst),
        .ID_ALUSrc(ID_ALUSrc),
        .EX_ALUSrc(EX_ALUSrc),
        .ID_RegData1(ID_Regdata1final),
        .ID_RegData2(ID_Regdata2final),
        .EX_RegData1(EX_Regdata1_result),
        .EX_RegData2(EX_Regdata2_result),
        .ID_SignExImm(ID_sign_extentedimm),
        .EX_SignExImm(EX_sign_extended_result),
        .ID_Rs(ID_Instruction[25:21]),
        .EX_Rs(EX_Rs),
        .ID_Rt(ID_Instruction[20:16]),
        .EX_Rt(EX_Rt),
        .ID_Rd(ID_Instruction[15:11]),
        .EX_Rd(EX_Rd)
    );
    
    // EX
    assign EX_Rdestination = (EX_RegDst) ? EX_Rd : EX_Rt;
    assign EX_func = EX_sign_extended_result[5:0];
    assign EX_ALU_B = (EX_ALUSrc) ? EX_sign_extended_result : EX_ALU_B_half;
    Mux_3_1_32bit Mux_ALU_A(
        .sel(forwardingALUin_control1),
        .in0(EX_Regdata1_result),
        .in1(wbwritedata),
        .in2(MEM_ALUresult),
        .out(EX_ALU_A)
    );
    Mux_3_1_32bit Mux_ALU_B1(
        .sel(forwardingALUin_control2),
        .in0(EX_Regdata2_result),
        .in1(wbwritedata),
        .in2(MEM_ALUresult),
        .out(EX_ALU_B_half)
    );
    ALU_control ALUControl(
        .ALUop(EX_ALUOp),
        .funct(EX_func),
        .control(EX_ALU_control)
    );
    ALU alu(
        .control(EX_ALU_control),
        .a(EX_ALU_A),
        .b(EX_ALU_B),
        .zero(EX_Zero),
        .result(EX_ALU_Result)
    );
    
    //EXMEM
    EX_MEM EXMEM(
        .clk(clk),
        .EX_RegWrite(EX_RegWrite),
        .MEM_RegWrite(MEM_RegWrite),
        .EX_MemtoReg(EX_MemtoReg),
        .MEM_MemtoReg(MEM_MemtoReg),
        .EX_MemWrite(EX_MemWrite),
        .MEM_MemWrite(MEM_MemWrite),
        .EX_MemRead(EX_MemRead),
        .MEM_MemRead(MEM_MemRead),
        .EX_ALUResult(EX_ALU_Result),
        .MEM_ALUResult(MEM_ALUresult),
        .EX_RegData2(EX_ALU_B_half),
        .MEM_RegData2(MEM_RegData2),
        .EX_RegisterRd(EX_Rdestination),
        .MEM_RegisterRd(MEM_Rd)
    );
    
    //MEM
    assign MEM_Writedata = (memSrc) ? wbmemdata : MEM_RegData2;
    data_memory DataMemory(
        .clk(clk),
        .MemRead(MEM_MemRead),
        .MemWrite(MEM_MemWrite),
        .address(MEM_ALUresult),
        .WriteData(MEM_Writedata),
        .ReadData(MEM_Readdata)
    );
    
    //MEMWB
    MEM_WB MEMWB(clk, MEM_RegWrite, MEM_MemtoReg, MEM_Rd, MEM_Readdata, MEM_ALUresult, wbregwrite, wbmemtoreg, WB_Rd, wbmemdata, wbALUresult);
    
    //WB
    assign wbwritedata = (wbmemtoreg) ? wbmemdata : wbALUresult;
    
    Hazard_Detection Hazard(
        .write(write),
        .flush(idexflush),
        .IF_ID_Rs(ID_Instruction[25:21]),
        .IF_ID_Rt(ID_Instruction[20:16]),
        .ID_EX_Rt(EX_Rt),
        .ID_EX_Rd(EX_Rdestination),
        .EX_MEM_Rd(MEM_Rd),
        .ID_EX_MemRead(EX_MemRead),
        .RegWrite_EX(EX_RegWrite),
        .Beq(ID_Beq),
        .Bne(ID_Bne),
        .MEM_MemRead(MEM_MemRead)
    );
    
    forwarding_unit ForwardingUnit(
        .ID_EX_Rs(EX_Rs),
        .ID_EX_Rt(EX_Rt),
        .IF_ID_Rs(ID_Instruction[25:21]),
        .IF_ID_Rt(ID_Instruction[20:16]),
        .MEM_WB_Rd(WB_Rd),
        .EX_MEM_Rd(MEM_Rd),
        .ID_EX_Rd(EX_Rdestination),
        .MEM_WB_RegWrite(wbregwrite),
        .MEM_WB_MemRead(wbmemread),
        .EX_MEM_RegWrite(MEM_RegWrite),
        .EX_MEM_MemWrite(MEM_MemWrite),
        .ID_EX_MemWrite(EX_MemWrite),
        .ID_EX_RegWrite(EX_RegWrite),
        .IF_ID_beq(ID_Beq),
        .IF_ID_bne(ID_Bne),
        .ForwardingALUin1(forwardingALUin_control1),
        .ForwardingALUin2(forwardingALUin_control2),
        .ForwardingEqin1(forwardingeq_control1),
        .ForwardingEqin2(forwardingeq_control2),
        .EX_MemSrc(memSrc)
    );
     
endmodule
