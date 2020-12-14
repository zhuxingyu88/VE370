`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/11/24 10:52:11
// Design Name: 
// Module Name: cache_2b
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


module cache_2b(
    input cpu_write,
    input [9:0] cpu_address,
    input [31:0] cpu_write_data,
    output reg [31:0] cpu_read_data,
    output reg cpu_hit
    );
    
    reg [31:0] caches [3:0][3:0];
    reg V [3:0];
    reg [4:0] tag [3:0];
    reg least_used [1:0];
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
            V[i]=1'b0;
            tag[i] = 4'b0;
            dirty[i] = 1'b0;
        end
        least_used[0] = 0;
        least_used[1] = 0;
    end
    
    always @(cpu_write or cpu_address or cpu_write_data) begin
        cpu_hit =  (V[{cpu_address[4],1'b0}] && tag[{cpu_address[4],1'b0}] == cpu_address[9:5]) || (V[{cpu_address[4],1'b1}] && tag[{cpu_address[4],1'b1}] == cpu_address[9:5]);
        if(cpu_hit)
            if (cpu_write) begin
                if(tag[{cpu_address[4],1'b0}] == cpu_address[9:5]) begin // block 0
                    least_used[cpu_address[4]] = 1;
                    dirty[{cpu_address[4],1'b0}] = 1;
                    caches[{cpu_address[4],1'b0}][cpu_address[3:2]] = cpu_write_data;
                    //mem_write_data = {caches[{cpu_address[4],1'b0}][0],caches[{cpu_address[4],1'b0}][1],caches[{cpu_address[4],1'b0}][2],caches[{cpu_address[4],1'b0}][3]};
                end
                else begin // block 1
                    least_used[cpu_address[4]] = 0;
                    dirty[{cpu_address[4],1'b1}] = 1;
                    caches[{cpu_address[4],1'b1}][cpu_address[3:2]] = cpu_write_data;
                    //mem_write_data = {caches[{cpu_address[4],1'b1}][0],caches[{cpu_address[4],1'b1}][1],caches[{cpu_address[4],1'b1}][2],caches[{cpu_address[4],1'b1}][3]};
                end
            end
            else begin // read
                if(tag[{cpu_address[4],1'b0}] == cpu_address[9:5]) begin // block 0
                     least_used[cpu_address[4]] = 1;
                     cpu_read_data = caches[{cpu_address[4],1'b0}][cpu_address[3:2]];
                end
                else begin // block 1
                     least_used[cpu_address[4]] = 0;
                     cpu_read_data = caches[{cpu_address[4],1'b1}][cpu_address[3:2]];
                end
            end
        else begin // miss
            if (dirty[{cpu_address[4], least_used[cpu_address[4]]}]) begin
                mem_address ={tag[{cpu_address[4], least_used[cpu_address[4]]}], cpu_address[4], 4'b0000};
                mem_write_data = {caches[{cpu_address[4], least_used[cpu_address[4]]}][0],caches[{cpu_address[4], least_used[cpu_address[4]]}][1],caches[{cpu_address[4], least_used[cpu_address[4]]}][2],caches[{cpu_address[4], least_used[cpu_address[4]]}][3]};
                mem_write = 1; 
            end
            #1 begin
                V[{cpu_address[4], least_used[cpu_address[4]]}] = 1;
                dirty[{cpu_address[4], least_used[cpu_address[4]]}] = 1'b0;
                tag[{cpu_address[4], least_used[cpu_address[4]]}] = cpu_address[9:5];
                mem_write = 0;
                mem_address = cpu_address;
            end
            #1 begin
                caches[{cpu_address[4], least_used[cpu_address[4]]}][0] = mem_read_data[127:96];
                caches[{cpu_address[4], least_used[cpu_address[4]]}][1] = mem_read_data[95:64];
                caches[{cpu_address[4], least_used[cpu_address[4]]}][2] = mem_read_data[63:32];
                caches[{cpu_address[4], least_used[cpu_address[4]]}][3] = mem_read_data[31:0];
                least_used[cpu_address[4]] = ~least_used[cpu_address[4]];
            end
        end
    end
endmodule
