`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/07 01:19:03
// Design Name: 
// Module Name: pipeline_testbanch
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


module pipeline_testbanch();

    integer t = 0;
	reg clk;

	pipeline uut (
		.clk(clk)
	);

	initial begin
		clk = 0;
        $display("Pipeline simulation:");
        $display("==========================================================");
        #600;
        $stop;
	end

    always #10 begin
        $display("Time:%d, CLK = %d, PC = 0x%H", t, clk, uut.PC_out);
        $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.registerFile.register_file[16], uut.registerFile.register_file[17], uut.registerFile.register_file[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.registerFile.register_file[19], uut.registerFile.register_file[20], uut.registerFile.register_file[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", uut.registerFile.register_file[22], uut.registerFile.register_file[23], uut.registerFile.register_file[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", uut.registerFile.register_file[9], uut.registerFile.register_file[10], uut.registerFile.register_file[11]);
        $display("[$t4] = 0x%H, [$t5] = 0x%H, [$t6] = 0x%H", uut.registerFile.register_file[12], uut.registerFile.register_file[13], uut.registerFile.register_file[14]);
        $display("[$t7] = 0x%H, [$t8] = 0x%H, [$t9] = 0x%H", uut.registerFile.register_file[15], uut.registerFile.register_file[24], uut.registerFile.register_file[25]);
        $display("M[0] = 0x%H, M[4] = 0x%H, M[8] = 0x%H", uut.DataMemory.memory[0], uut.DataMemory.memory[1], uut.DataMemory.memory[2]);
        $display("----------------------------------------------------------");
        clk = ~clk;
        if (~clk) t = t + 1;
    end

endmodule
