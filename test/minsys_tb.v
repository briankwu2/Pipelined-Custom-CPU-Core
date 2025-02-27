`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:54:26 03/27/2023
// Design Name:   minsys
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/minsys_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: minsys
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module minsys_tb;

	// Inputs
	reg clk;
	reg rst;
	reg EI;
	reg [7:0] SW;
	reg [3:0] Keypad_rows;

	// Outputs
	wire [9:0] vga_cont;
	wire [3:0] Keypad_cols;

	// Instantiate the Unit Under Test (UUT)
	minsys uut (
		.clk(clk), 
		.rst(rst), 
		.EI(EI), 
		.SW(SW), 
		.vga_cont(vga_cont), 
		.Keypad_rows(Keypad_rows), 
		.Keypad_cols(Keypad_cols)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		EI = 0;
		SW = 0;
		Keypad_rows = 0;
		// Wait 100 ns for global reset to finish
		#100;
		clk = 1;
		EI = 1;
		SW = 50;
		Keypad_rows = 4'b1111;
		
		#100;
		rst = 1;
		EI = ~EI;
		#50;
		EI = ~EI;
		
		forever #50 clk = ~clk;
	
        
		// Add stimulus here

	end
      
endmodule

