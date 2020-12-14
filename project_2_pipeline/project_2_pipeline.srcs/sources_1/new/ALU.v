`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/01 11:32:10
// Design Name: 
// Module Name: ALU
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


module ALU (
    input [3:0] control,
    input [31:0] a, b,
    output zero,
    output reg [31:0] result
);

    initial begin
        result = 32'b0;
    end

    always @ (*) begin
        case (control)
            4'b0000: // AND
                result = a & b;
            4'b0001: // OR
                result = a | b;
            4'b0010: // ADD
                result = a + b;
            4'b0110: // SUB
                result = a - b;
            4'b0111: // SLT
                result = (a < b) ? 1 : 0;
            4'b1100: // NOR
                result = ~(a | b);
            default: 
                result = a;
        endcase
    end
    
    assign zero = (result == 0);

endmodule 