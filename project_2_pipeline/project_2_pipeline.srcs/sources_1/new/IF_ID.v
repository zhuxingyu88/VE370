`timescale 1ns / 1ps

module IF_ID(
    input clk,
    input IF_ID_Write,
    input IF_Flush,
    input [31:0] IF_Instuction,
    input [31:0] IF_PC_plus_4,
    output reg [31:0] ID_Instuction,
    output reg [31:0] ID_PC_plus_4
    );
    
    initial begin
        ID_Instuction = 32'b0;
        ID_PC_plus_4 = 32'b0;
    end

    always @(posedge clk) begin
        if(IF_Flush) begin
            ID_Instuction <= 32'b0;
            ID_PC_plus_4 <= 32'b0;
        end 
        else if (IF_ID_Write) begin
            ID_Instuction <= IF_Instuction;   
            ID_PC_plus_4 <= IF_PC_plus_4;
        end
        else begin
            ID_Instuction <= ID_Instuction;
            ID_PC_plus_4 <= ID_PC_plus_4;
        end
    end
    
endmodule