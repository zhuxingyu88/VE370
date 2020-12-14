`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 12:54:19
// Design Name: 
// Module Name: p2_testbanch
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


module p2_testbanch;
    reg [4:0] Readreg;
    reg Readpc;
    reg manual_clk;
    reg clk;
    wire [3:0] AN;
    wire [6:0] ssd;

    p2 UUT(Readreg, Readpc, manual_clk, clk, AN, ssd);
    
    initial begin
        #0;
        clk = 0;
        manual_clk = 0;
        Readpc = 1;
        Readreg = 4'b0;
        #60 $stop;
    end

    always #0.00005 begin
        clk = ~clk;
    end
    always #3 begin
        manual_clk = ~manual_clk;
    end;
endmodule
