`timescale 1ns / 1ps

module Hazard_Detection(Beq, Bne, ID_EX_MemRead, RegWrite_EX, MEM_MemRead, IF_ID_Rs, IF_ID_Rt, ID_EX_Rt, ID_EX_Rd, EX_MEM_Rd, write, flush);
    input Beq, Bne, ID_EX_MemRead, RegWrite_EX, MEM_MemRead;
    input [4:0] IF_ID_Rs, IF_ID_Rt, ID_EX_Rt, ID_EX_Rd, EX_MEM_Rd;
    output reg write, flush;
    
    initial begin
        write = 1'b1;
        flush = 1'b0;
    end
    
    always @ (*) begin
        if (ID_EX_MemRead && (ID_EX_Rt != 0) && (ID_EX_Rt == IF_ID_Rs || ID_EX_Rt == IF_ID_Rt)) begin
            // lw in previous 1 instruction
            // load_use hazard
            write = 1'b0;
            flush = 1'b1;
        end else if (Beq || Bne) begin
            if (RegWrite_EX && (ID_EX_Rd != 0) && (ID_EX_Rd == IF_ID_Rs || ID_EX_Rd == IF_ID_Rt)) begin
                // R-type in previous 1 instruction
                write = 1'b0;
                flush = 1'b1;
        end else if (MEM_MemRead && (EX_MEM_Rd != 0) && (EX_MEM_Rd == IF_ID_Rs || EX_MEM_Rd == IF_ID_Rt)) begin
            // lw in previous 2 instruction
            write = 1'b0;
            flush = 1'b1;
        end else begin
            // registers have no dependencies
            write = 1'b1;
            flush = 1'b0;
            end
        end 
    else begin
        // not branch
        write = 1'b1;
        flush = 1'b0;
        end
    end  
endmodule
