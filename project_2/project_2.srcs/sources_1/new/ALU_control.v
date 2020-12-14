`timescale 1ns / 1ps

module ALUControl (
	input [1:0]	ALUop,
	input [5:0]	funct,
	output reg [3:0] control
);

	always @(ALUop, funct) begin
		case (ALUop)
			2'b00: // lw sw addi
				control = 4'b0010;
			2'b01: // beq
				control = 4'b0110;
			2'b10:
				case (funct)
					6'b100000: //add
						control = 4'b0010;
					6'b100010: // sub
						control = 4'b0110;
					6'b100100: // and
						control = 4'b0000;
					6'b100101: // or
						control = 4'b0001;
					6'b101010: // slt
						control = 4'b0111;
					default : ;
				endcase
			2'b11: // andi
				control = 4'b0000;
			default : ;
		endcase
	end

endmodule