`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 09:54:43
// Design Name: 
// Module Name: cache_2a
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


module cache_2a(
    input cpu_write,
    input [9:0] cpu_address,
    input [31:0] cpu_write_data,
    output reg [31:0] cpu_read_data,
    output reg cpu_hit
    );
    
    reg [31:0] caches [3:0][3:0];
    reg V [3:0];
    reg [3:0] tag [3:0];
    reg dirty [3:0];
    
    reg mem_write;
    reg [9:0] mem_address;
    reg [127:0] mem_write_data;
    wire [127:0] mem_read_data;
    
    
    main_memory mainMemory(mem_write, mem_address, mem_write_data, mem_read_data);
    
    integer i, j;
    initial begin
        for(i = 0; i < 4; i = i + 1) begin
            for(j = 0; j < 4; j = j +1) begin
                caches[i][j]=32'b0;
            end
            V[i] = 1'b0;
            tag[i] = 4'b0;
            dirty[i] = 1'b0;
        end
    end
    
    always @(cpu_write or cpu_address or cpu_write_data) begin
        cpu_hit = (V[cpu_address[5:4]] && tag[cpu_address[5:4]] == cpu_address[9:6]) ? 1:0;
        if(cpu_hit)
            if (cpu_write) begin
                caches[cpu_address[5:4]][cpu_address[3:2]] = cpu_write_data;
                dirty[cpu_address[5:4]] = 1;
            end
            else
                cpu_read_data = caches[cpu_address[5:4]][cpu_address[3:2]];
        else begin
            if (dirty[cpu_address[5:4]]) begin
                mem_address ={tag[cpu_address[5:4]], cpu_address[5:4], 4'b0000};
                mem_write_data = {caches[cpu_address[5:4]][0],caches[cpu_address[5:4]][1],caches[cpu_address[5:4]][2],caches[cpu_address[5:4]][3]};
                mem_write = 1;
            end
            #1 begin
            V[cpu_address[5:4]] = 1;
            dirty[cpu_address[5:4]] = 0;
            tag[cpu_address[5:4]] = cpu_address[9:6];
            mem_write = 0;
            mem_address = cpu_address;
            end
            #1 begin
                caches[cpu_address[5:4]][0] = mem_read_data[127:96];
                caches[cpu_address[5:4]][1] = mem_read_data[95:64];
                caches[cpu_address[5:4]][2] = mem_read_data[63:32];
                caches[cpu_address[5:4]][3] = mem_read_data[31:0];
            end
        end 
    end
endmodule
