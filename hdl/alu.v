`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:51:22 03/15/2023 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu(
	 input [ALU_OPERAND_WIDTH - 1:0] A,
    input [ALU_OPERAND_WIDTH - 1:0] B,
    input [ALU_INPUT_PORT_DATA_WIDTH- 1:0] input_port_data,
    input [ALU_INPUT_PORT_KEYB_WIDTH- 1:0] input_port_kb,
    input [ALU_FUNCTION_SELECT_WIDTH - 1:0] function_select,
    input [ALU_SHIFT_SIZE- 1:0] shift,
    output [ALU_OPERAND_WIDTH - 1:0] F, // Result
    output C, // Carry Over
    output Z, // Zero Compare
    output V, // Overflow
    output N // Negative
);


	// ALU
	parameter ALU_OPERAND_WIDTH = 8;
	parameter ALU_FUNCTION_SELECT_WIDTH =  4;
	parameter ALU_SHIFT_SIZE = 3;
	parameter ALU_INPUT_PORT_DATA_WIDTH = 8;
	parameter ALU_INPUT_PORT_KEYB_WIDTH = 8;

	// ALU Operation
	parameter ALU_OP_ADD = 0;
	parameter ALU_OP_SUB = 1;
	parameter ALU_OP_AND = 2;
	parameter ALU_OP_OR = 3;
	parameter ALU_OP_XOR = 4;
	parameter ALU_OP_COMPLEMENT = 5;
	parameter ALU_OP_SHIFT_LEFT = 6;
	parameter ALU_OP_SHIFT_RIGHT = 7;
	parameter ALU_OP_CMP_ZERO = 8;
	parameter ALU_OP_CMP = 9;
   parameter ALU_OP_INPUT = 10;
   parameter ALU_OP_INKEY = 11;
   parameter ALU_OP_JML = 12;
   parameter ALU_OP_MOV = 13;

    reg [ALU_OPERAND_WIDTH:0] result; // Will extend the normal width by 1 bit, and have the MSB bit as Carry
	 reg v_flag;
	 
    always @ (*) // On any input change
    begin
        case(function_select)
            ALU_OP_ADD:
                result <= A + B;
            ALU_OP_SUB:
                result <= A + ~(B) + 8'b1;
            ALU_OP_AND:
                result <= A & B;
            ALU_OP_OR:
                result <= A | B;
            ALU_OP_XOR:
                result <= A ^ B;
            ALU_OP_COMPLEMENT:
                result <= ~A;
            ALU_OP_SHIFT_LEFT: 
                result <= A << shift;
            ALU_OP_SHIFT_RIGHT:
                result <= A >> shift;
            ALU_OP_CMP_ZERO:
                result <= (A == 0)? 9'b1 : 9'b0;
            ALU_OP_CMP: // If a is less than b, output 1 otherwise 0
                result <= (A < B)? 9'b1: 9'b0;
            ALU_OP_INPUT: 
               result <= input_port_data;
            ALU_OP_INKEY: 
               result <= input_port_kb;
            ALU_OP_JML: // Unsure how to implement
               result <= 0; //for now
            ALU_OP_MOV: // Moves Register A into Register File at DA 
               result <= A;
            default:
                result <= 0;
					 
			
        endcase
		
			// Assign Overflow Flag
			case (result[ALU_OPERAND_WIDTH:ALU_OPERAND_WIDTH-1])
         2'b00: v_flag = 1'b0;
         2'b01: v_flag = 1'b1;
         2'b10: v_flag = 1'b1;
         2'b11: v_flag = 1'b0;

         default: 
            v_flag = 1'bZ;
				
			endcase
		 
		 end
	 
      // Assign outputs with resulting operations
		 assign F = result[ALU_OPERAND_WIDTH-1:0];
		 assign C = result[ALU_OPERAND_WIDTH]; // Assign the Carry Bit
		 assign V = v_flag;
		 assign Z = (result == 0) ? 1'b1: 1'b0;
		 assign N = result[ALU_OPERAND_WIDTH - 1];

endmodule
