module instr_decoder(
    input [INSTR_SIZE-1:0] instr_line,
    output reg [REG_ADDRESS_SIZE-1:0] DA, // Destination Address: Where to write to
    output reg [REG_ADDRESS_SIZE-1:0] AA, // A-Register Address: Read from Register File
    output reg [REG_ADDRESS_SIZE-1:0] BA, // B-Register: Read from Register File
    output reg [1:0] BS, // Branch Select: detects branches and effects on PC
    output reg PS, // Zero Toggle: Controls type of conditional branch (Z or N)
    output reg MW, // Memory Write: MW==1 - Write, MW==0 - Read
    output reg RW, // Register Write: Enables writing to register file. RW==1 - Write, RW==0 - Read
    output reg MA, // MUXA Select
    output reg MB, // MUXB Select
    output reg [1:0] MD, // MUXD Select
    output reg [ALU_FUNCTION_SELECT_WIDTH-1:0] FS, // ALU Function Select: (ALU's operation)
    output reg [ALU_SHIFT_SIZE-1:0] SH, // Shift Number: Number of shifts in the ALU for related operation
    output reg CS, // Constant Unit Select: Controls zero fill or sign extensions of immediate values in CU
    output reg OE // Output Enable: enables writing data to output port
);


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

	//OPCODES
	parameter INSTR_NOP = 0;
	parameter INSTR_LD = 1;
	parameter INSTR_ST = 2;
	parameter INSTR_MOV = 3;
	parameter INSTR_JMP = 4;
	parameter INSTR_JMR = 5;
	parameter INSTR_JML = 6;
	parameter INSTR_BZ = 7;
	parameter INSTR_BZL = 8;
	parameter INSTR_IN = 9;
	parameter INSTR_OUT = 10;
	parameter INSTR_INKEY = 11;
	parameter INSTR_LSL = 12;
	parameter INSTR_LSR = 13;
	parameter INSTR_XOR = 14;
	parameter INSTR_AND = 15;
	parameter INSTR_ORI = 16;
	parameter INSTR_SLT = 17;
	parameter INSTR_ADD = 18;
	parameter INSTR_SUB = 19;
	parameter INSTR_ADDI = 20;
	parameter INSTR_COM = 21;


	// Other Parameters
	parameter INSTR_OPCODE_SIZE = 5; 
	parameter INSTR_OP_LSB = INSTR_SIZE - INSTR_OPCODE_SIZE; // Should be 12
	parameter DA_MSB = INSTR_OP_LSB - REG_ADDRESS_SIZE; // Should be 9
	parameter AA_MSB = DA_MSB - REG_ADDRESS_SIZE; // Should be 6
	parameter BA_MSB = AA_MSB - REG_ADDRESS_SIZE; // Should be 3
	
	
	parameter INSTR_SIZE = 17;
	parameter REG_ADDRESS_SIZE = 3;
	parameter ALU_FUNCTION_SELECT_WIDTH =  4;
	parameter ALU_SHIFT_SIZE = 3;
	

	reg [INSTR_OPCODE_SIZE-1:0] opcode;
	/*
	Questions:
	- The FS for some, what kind of ALU implmentation do they need?
	*/


	always @ (*)
	begin
		 opcode = instr_line[INSTR_SIZE-1:INSTR_OP_LSB]; // Get the opcode from the instr_line
		 // DA, AA, BA are these unless specified/overwritten in any case statements for branch or immediate instructions
		 DA <= instr_line[INSTR_OP_LSB-1:DA_MSB];
		 AA <= instr_line[DA_MSB-1:AA_MSB];
		 BA <= instr_line[AA_MSB-1:BA_MSB];
       SH <= 3'b000; // Default shift amount is 0 unless specified (LSL, LSR)
		 case(opcode)
			  INSTR_NOP:
            begin
					RW <= 1'b0;
					MD <= 2'bXX;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= 4'bXXXX;
					MB <= 1'bX;
					MA <= 1'bX;
					CS <= 1'bX;
					OE <= 1'b0;
            end
			  INSTR_LD: 
            begin
               
					RW <= 1'b1;
					MD <= 2'b01;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= 4'bXXXX;
					MB <= 1'bX;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
            end
			  INSTR_ST:
            begin 
            
					RW <= 1'b0;
					MD <= 2'bXX;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b1;
					FS <= 4'bXXXX;
					MB <= 1'b0;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
            end
			  INSTR_MOV: 
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_MOV;
					MB <= 1'bX;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
           end

			  INSTR_JMP:
           begin
           		RW <= 1'b0;
					MD <= 2'bXX;
					BS <= 2'b11;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= 4'bXXXX;
					MB <= 1'b1;
					MA <= 1'bX;
					CS <= 1'b1;
					OE <= 1'b0;
           end
			  INSTR_JMR:
           begin             
					RW <= 1'b0;
					MD <= 2'bXX;
					BS <= 2'b10;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= 4'bXXXX;
					MB <= 1'bX;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
           end
			  INSTR_JML: // FIXME: Not Implemented Currently
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b11;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= 4'bXXXX; // Why is this not XXXX? ALU_OP_JML Not Implemented
					MB <= 1'b1;
					MA <= 1'b1;
					CS <= 1'b1;
					OE <= 1'b0;
           end
			  INSTR_BZL:
           begin              
					RW <= 1'b0;
					MD <= 2'bXX;
					BS <= 2'b01;
					PS <= 1'b0;
					MW <= 1'b0;
					FS <= ALU_OP_CMP_ZERO; // Why is this not XXXX? What operation does ALU need to do?
					MB <= 1'b1;
					MA <= 1'b1;
					CS <= 1'b1;
					OE <= 1'b0;
           end
			  INSTR_IN:
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_INPUT; 
					MB <= 1'b0;
					MA <= 1'b0;
					CS <= 1'b0;
					OE <= 1'b0;
           end
			  INSTR_OUT:
           begin
					RW <= 1'b0;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= 4'bXXXX; 
					MB <= 1'b0;
					MA <= 1'b0;
					CS <= 1'b0;
					OE <= 1'b1;
           end
           INSTR_INKEY:
			  begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_INKEY; 
					MB <= 1'b0;
					MA <= 1'b0;
					CS <= 1'b0;
					OE <= 1'b0;
				end
			  INSTR_LSL: 
           begin
               BA <= 3'b000; // BA is always 0 for LSL
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_SHIFT_LEFT;
					MB <= 1'bX;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
               SH <= instr_line[2:0];
           end
			  INSTR_LSR: 
           begin
               BA <= 3'b000; // BA is always 0 for LSR
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_SHIFT_RIGHT;
					MB <= 1'bX;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
               SH <= instr_line[2:0];
           end
			  INSTR_XOR:
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_XOR; 
					MB <= 1'bX;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
           end
			  INSTR_AND:
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_AND; 
					MB <= 1'b0;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
           end
			  INSTR_ORI:
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_OR; // Does this need a separate ALU_OP_ORI code?
					MB <= 1'b1;
					MA <= 1'b0;
					CS <= 1'b0;
					OE <= 1'b0;
           end
			  INSTR_SLT:
           begin
               BA <= 3'b000; // BA is always 0 for SLT 
					RW <= 1'b1;
					MD <= 2'b10;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_CMP; 
					MB <= 1'b0;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
           end
			  INSTR_ADD:
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_ADD; 
					MB <= 1'b0;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
           end
			  INSTR_SUB:
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_SUB; 
					MB <= 1'b0;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
           end
			  INSTR_ADDI:
           begin
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_ADD; 
					MB <= 1'b1;
					MA <= 1'b0;
					CS <= 1'b1;
					OE <= 1'b0;
           end
			  INSTR_COM:
           begin
               BA <= 3'b000;
					RW <= 1'b1;
					MD <= 2'b00;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= ALU_OP_COMPLEMENT; 
					MB <= 1'bX;
					MA <= 1'b0;
					CS <= 1'bX;
					OE <= 1'b0;
           end
			  default:
           begin
					RW <= 1'b0;
					MD <= 2'bXX;
					BS <= 2'b00;
					PS <= 1'bX;
					MW <= 1'b0;
					FS <= 4'bXXXX;
					MB <= 1'bX;
					MA <= 1'bX;
					CS <= 1'bX;
					OE <= 1'b0;
           end
		 endcase

	end
endmodule