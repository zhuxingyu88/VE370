`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 11:18:18
// Design Name: 
// Module Name: p2
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


module p2(
    input [4:0] Readreg,
    input Readpc,
    input manual_clk,
    input clk,
    output [3:0] AN,
    output reg [6:0] ssd
    );
    
    
    wire clk_500;
    wire [3:0] Q0_r, Q1_r, Q2_r, Q3_r;
    wire [6:0] temp1, temp2, temp3, temp4;
    
    wire [31:0] pipe_out;
    wire [31:0] PC_out;
    wire [31:0] Reg_out;

    clock_divider clockDivider(clk, clk_500);
    counter_ring_4 ringCounter(clk_500, AN);
    pipeline pipeline_register(manual_clk, Readreg, PC_out, Reg_out);
    
    assign pipe_out = (Readpc) ? PC_out : Reg_out;
    fourbit_ssd_num SSD1(pipe_out[15:12], temp1); // left most
    fourbit_ssd_num SSD2(pipe_out[11:8], temp2);
    fourbit_ssd_num SSD3(pipe_out[7:4], temp3);
    fourbit_ssd_num SSD4(pipe_out[3:0], temp4); // right most
    
    always @(AN)
    begin
        case (AN)
            4'b0111: ssd = temp1;
            4'b1011: ssd = temp2;
            4'b1101: ssd = temp3;
            4'b1110: ssd = temp4;
            default: ssd = 7'b1111111;
        endcase
    end
endmodule
