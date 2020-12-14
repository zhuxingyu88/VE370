`timescale 1ns / 1ps

module clock_divider(clk_500, clk_1);
parameter div = 20000;
input clk_500;
output clk_1;
reg clk_1;
reg [17:0] count = 17'b0;
always @(posedge clk_500) 
begin
    if (count == div - 1) 
        begin 
            count <= 9'b0;
            clk_1 <= 1'b1;
        end
    else
        begin 
            count <= count + 1;
            clk_1 <= 1'b0;
        end
end
endmodule
