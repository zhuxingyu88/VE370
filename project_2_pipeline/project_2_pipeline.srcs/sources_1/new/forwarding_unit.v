`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/06 12:50:23
// Design Name: 
// Module Name: forwarding_unit
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


module forwarding_unit(
    input [4:0] ID_EX_Rs, ID_EX_Rt, IF_ID_Rs, IF_ID_Rt, MEM_WB_Rd, EX_MEM_Rd, ID_EX_Rd,
    input MEM_WB_RegWrite, MEM_WB_MemRead, EX_MEM_RegWrite, EX_MEM_MemWrite, ID_EX_MemWrite, ID_EX_RegWrite, IF_ID_beq, IF_ID_bne,
    output reg [1:0] ForwardingALUin1,
    output reg [1:0] ForwardingALUin2,
    output reg [1:0] ForwardingEqin1,
    output reg [1:0] ForwardingEqin2,
    output reg EX_MemSrc
    );
    
    
    initial begin
        ForwardingALUin1 = 2'b00;
        ForwardingALUin2 = 2'b00;
        EX_MemSrc = 1'b00;
        end
    
    always @(*) begin
        //Data hazard at A
        if(EX_MEM_RegWrite && EX_MEM_Rd && EX_MEM_Rd == ID_EX_Rs) // ex
            ForwardingALUin1 = 2'b10;
        else if(MEM_WB_RegWrite && MEM_WB_Rd && MEM_WB_Rd == ID_EX_Rs) // mem
            ForwardingALUin1 = 2'b01;
        else 
            ForwardingALUin1 = 2'b00;
            
        //Data hazard at B
        if(EX_MEM_RegWrite && EX_MEM_Rd && EX_MEM_Rd == ID_EX_Rt) //ex
            ForwardingALUin2 = 2'b10;
        else if(MEM_WB_RegWrite && MEM_WB_Rd && MEM_WB_Rd == ID_EX_Rt) //mem
            ForwardingALUin2 = 2'b01;
        else 
            ForwardingALUin2 = 2'b00;
        
        // data hazard of lw sw
        if(MEM_WB_MemRead && EX_MEM_MemWrite && MEM_WB_Rd == EX_MEM_Rd)      
            EX_MemSrc = 1'b1;
        else
            EX_MemSrc = 1'b0;
    
        // branch data hazard
        if((IF_ID_beq || IF_ID_bne) && EX_MEM_RegWrite && EX_MEM_Rd && EX_MEM_Rd == IF_ID_Rs)
            ForwardingEqin1 = 2'b10;
        else if (MEM_WB_MemRead && MEM_WB_RegWrite && MEM_WB_Rd && MEM_WB_Rd == IF_ID_Rs && (IF_ID_beq || IF_ID_bne))
            ForwardingEqin1 = 2'b01;
        else
            ForwardingEqin1 = 2'b00;
    
        if((IF_ID_beq || IF_ID_bne) && EX_MEM_RegWrite && EX_MEM_Rd && EX_MEM_Rd == IF_ID_Rt)
            ForwardingEqin2 = 2'b10;
        else if ((IF_ID_beq || IF_ID_bne) && MEM_WB_MemRead && MEM_WB_RegWrite && MEM_WB_Rd && MEM_WB_Rd == IF_ID_Rt)
            ForwardingEqin2 = 2'b01;
        else
            ForwardingEqin2 = 2'b00;
        end

endmodule
