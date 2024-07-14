//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:13:50 03/16/2023 
// Design Name: 
// Module Name:    parameters 
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
// File for storing size parameters
// DEPRECATED
// Unsure why but parameters using the `include "..v" wasn't working unfortunately
// Kept for list of parameters
parameter INSTR_OPCODE_SIZE = 5;
parameter INSTR_SIZE = 17;
parameter DATA_ADDRESS_WIDTH = 8;
parameter DATA_WIDTH = 8;
parameter NUM_ADDRESSES = 256;

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

// Registers
parameter REG_ADDRESS_SIZE = 3;
parameter REG_SIZE = 8;
parameter REG_DATA_WIDTH = 8;
parameter MUX_BIT_WIDTH = 8;
parameter IMMEDIATE_WIDTH = INSTR_SIZE - INSTR_OPCODE_SIZE - (2 * REG_ADDRESS_SIZE) ;

//OPCODES
parameter INSTR_NOP = 0;
parameter INSTR_LD = 1;
parameter INSTR_ST = 2;
parameter INSTR_MOV = 3;
parameter INSTR_JMP = 4;
parameter INSTR_JMR = 5;
parameter INSTR_JML = 6;
parameter INSTR_BZ = 7;
parameter INSTR_BNZ = 8;
parameter INSTR_IN = 9;
parameter INSTR_OUT = 10;
parameter INSTR_LSL = 11;
parameter INSTR_LSR = 12;
parameter INSTR_XOR = 13;
parameter INSTR_AND = 14;
parameter INSTR_ORI = 15;
parameter INSTR_SLT = 16;
parameter INSTR_ADD = 17;
parameter INSTR_SUB = 18;
parameter INSTR_ADDI = 19;
parameter INSTR_COM = 20;