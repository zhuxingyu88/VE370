`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/03 23:17:27
// Design Name: 
// Module Name: single_cycle_sim
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


module single_cycle_sim(

    );
    integer t = 0;
    reg clk;
    
    single_cycle uut (clk);
    
        initial begin
            clk = 0;
            $display("Single cycle simulation:");
            $display("==========================================================");
             uut.regFile.register_file[8] = 32;
            #600;
            $stop;
        end
    
        always #10 begin
            $display("Time: %d ns, Clock = %d, PC = 0x%H", t, clk, uut.PC_out);
            $display("[$zero] = 0x%H, [$t0] = 0x%H, [$t1] = 0x%H", uut.regFile.register_file[0], uut.regFile.register_file[8], uut.regFile.register_file[9]);
            $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.regFile.register_file[16], uut.regFile.register_file[17], uut.regFile.register_file[18]);
            $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.regFile.register_file[19], uut.regFile.register_file[20], uut.regFile.register_file[21]);
            $display("M[0] = 0x%H, M[4] = 0x%H, M[8] = 0x%H", uut.dataMemory.memory[0], uut.dataMemory.memory[4], uut.dataMemory.memory[8]);
            $display("----------------------------------------------------------");
            clk = ~clk;
            if(!clk)
                t = t + 1;
        end
    
endmodule
