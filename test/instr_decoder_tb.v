`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:30:33 03/17/2023
// Design Name:   instr_decoder
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/instr_decoder_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: instr_decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module instr_decoder_tb;

	// Inputs
	reg [16:0] instr_line;

	// Outputs
	wire [2:0] DA;
	wire [2:0] AA;
	wire [2:0] BA;
	wire [1:0] BS;
	wire PS;
	wire MW;
	wire RW;
	wire MA;
	wire MB;
	wire [1:0] MD;
	wire [3:0] FS;
	wire [2:0] SH;
	wire CS;
	wire OE;

	// Instantiate the Unit Under Test (UUT)
	instr_decoder uut (
		.instr_line(instr_line), 
		.DA(DA), 
		.AA(AA), 
		.BA(BA), 
		.BS(BS), 
		.PS(PS), 
		.MW(MW), 
		.RW(RW), 
		.MA(MA), 
		.MB(MB), 
		.MD(MD), 
		.FS(FS), 
		.SH(SH), 
		.CS(CS), 
		.OE(OE)
	);
	
	
	integer i;
	initial begin
		// Initialize Inputs
		instr_line = 0;

		// Wait 100 ns for global reset to finish
		#100;

                                          //   ADD |DA(R1)|AA(R2)|BA(R3)| N/A |
      instr_line = 17'b00000001010011000; // |00000| 001  | 010  | 011  | XXX |
      #100;                               

      for (i = 0; i < 21; i = i + 1)
      begin
         instr_line = instr_line & ~(17'b11111000000000000); // Resets the opcode
         instr_line = instr_line | (i << 12); // Sets the opcode to i 
         #100;
      end


	end
      
endmodule

