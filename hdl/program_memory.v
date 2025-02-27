`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:23:16 01/23/2023 
// Design Name: 
// Module Name:    program_memory 
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
module program_memory(
   input [ADDRESS_WIDTH - 1:0] address_in_bus,
   output [PROGRAM_DATA_WIDTH - 1:0] data_out_bus
   );

	// What to initialize, how to even put things in here?
	// Intial Block?
	
	
	parameter ADDRESS_WIDTH = 8;
	parameter PROGRAM_DATA_WIDTH = 17;
	parameter NUM_ADDRESSES = 256;
	
	reg [PROGRAM_DATA_WIDTH - 1:0] prog_mem [NUM_ADDRESSES - 1:0];
	
	
	// For loading in programs
	initial begin

	// Program 1:
	// Assume A is R1, and B is R2.
	// Assume C is R3.
	// A = A + 20; (addi R1, 
	// B = A + 15;
	// C = A + B;
	
	// Assembly Equivalent:
	// Assembly Equivalent: 
	// 1: addi R2, R2, 15  (B = B + 15) R2 = 15
	// EXPLAIN CODE: |addi (20)| DA(R1)| AA(R1) | Immed(15)|
	// MACHINE CODE: |  10100  |  010  | 010    | 001111  |
	// HEXADECIMAL CODE: 1 0100 0100 1000 1111 = 0x1448f
	//prog_mem[0] = 17'h1448f;
	
	// Assembly Equivalent:
	// 2: addi R1, R1, 20 (A = A + 20) R1 = 20
	// EXPLAIN CODE: |addi (20)| DA(R1)| AA(R1) | Immed(20)|
	// MACHINE CODE: |  10100  |  001  | 001    | 010100  |
	// HEXADECIMAL CODE: 1 0100 0010 0101 0100 = 0x14254
	//prog_mem[1] = 17'h14254;
	
	// Assembly Equivalent:
	// 3: addi R2, R2, 15  (B = B + 15) (30) R2 = 30
	// EXPLAIN CODE: |addi (20)| DA(R1)| AA(R1) | Immed(15)|
	// MACHINE CODE: |  10100  |  010  | 010    | 001111  |
	// HEXADECIMAL CODE: 1 0100 0100 1000 1111 = 0x1448f
	//prog_mem[2] = 17'h1448f;

	// Assembly Equivalent:
	// 3: add R3, R1, R2 (C = A + B)  30 + 20 = 50 | R3 = 50
	// EXPLAIN CODE: |add (18)| DA(R3)| AA(R1)|BA(R2)| N/A |
	// MACHINE CODE: | 10010  |  011  | 001   | 010  | 000 |
	// HEXADECIMAL CODE: 1 0010 0110 0101 0000 = 0x12650
	//prog_mem[3] = 17'h12650;
	
	// Assembly Equivalent:
	// 4: st R2, R3 (Stores R3 into address of what is stored in R2)
	// Register A is the Data Memory Address
	// Register B is the Value you want to write
	// EXPLAIN CODE: |st(2)  | DA(X) | AA(R2) | BA (Value)| N/A |
	// MACHINE CODE: |00010  |  000  |   010  | 011       | 000 |
	// HEXADECIMAL CODE: 0 0010 0000 1001 1000 = 0x02098
	//prog_mem[4] = 17'h02098;
	
	// END RESULT:
	// R2 = 30
	// R3 = 50
	// Data Memory: (0x30) = 50 
	// Success
	
	
	// Program 2:
	// Test IN, INKEY, OUT, JMR
	
	// Assembly Equivalent:
	// 1: IN R1
	// // Stores the input into R1 (DA). R(DA) <= IN
	// EXPLAIN CODE: |IN (9) | DA (R1) | AA(X))| BA (X)    | N/A |
	// MACHINE CODE: |01001  |  001    |  000  | 000       | 000 |
	// HEXADECIMAL CODE: 0 1001 0010 0000 0000  = 0x09200
	prog_mem[0] = 17'h09200;
	
	
	// Assembly Equivalent:
	// 2: INKEY R2
	// // Stores the keyboard input into R2 (DA). R(DA) <= INKEY
	// EXPLAIN CODE: |INKEY (11) | DA (R2) | AA(X))| BA (X)    | N/A |
	// MACHINE CODE: |    01011  |  010    |  000  | 000       | 000 |
	// HEXADECIMAL CODE: 0 1011 0100 0000 0000 = 0x0b800
	prog_mem[1] = 17'h0b400;
	
	// Assembly Equivalent:
	// 3: OUT R2, R1
	// Outputs R2 and R1 into OUTPUT_LSB and OUTPUT_MSB. R[SA] and R[SB] are OUTPUT_LSB, OUTPUT_MSB respectively.
	// EXPLAIN CODE: |OUT (10) | DA (X)  | AA(R2))| BA (R1)   | N/A |
	// MACHINE CODE: |  01010 |  000    |  010   | 001       | 000 |
	// HEXADECIMAL CODE: 0 1010 0000 1000 1000 = 0x0a088
	prog_mem[2] = 17'h0a088;
	
	
	// END RESULT: OUTPUT_LSB = KB_input  OUTPUT_LSB = data_input
	

	// Assembly Equivalent:
	// 4: JMR R0 (uses AA)
	// Jumps to R0 (INSTR 0). PC <= R0. AA is R0. 
	// EXPLAIN CODE: |JMR (5) | DA (X)  | AA(R0))| BA (X)    | N/A |
	// MACHINE CODE: |  00101 |  000    |  000   | 000       | 000 |
	// HEXADECIMAL CODE: 0 0101 0000 0000 0000 = 0x05000
	prog_mem[3] = 17'h05000;
	
	 
	end
	
	assign data_out_bus = prog_mem[address_in_bus];
	

endmodule