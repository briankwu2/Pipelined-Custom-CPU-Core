`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:20:52 04/03/2023
// Design Name:   mcu_io
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/mcu_io_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mcu_io
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module mcu_io_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] Color;
	reg [7:0] Grid_Position;
	reg [7:0] SW;
	reg EIs;
	reg [3:0] Keypad_rows;

	// Outputs
	wire [7:0] sw_pos;
	wire [9:0] vga_cont;
	wire [3:0] Keypad_cols;
	wire [7:0] Decoded_keyboard;

	// Instantiate the Unit Under Test (UUT)
	mcu_io uut (
		.clk(clk), 
		.rst(rst), 
		.Color(Color), 
		.Grid_Position(Grid_Position), 
		.sw_pos(sw_pos), 
		.SW(SW), 
		.EIs(EIs), 
		.vga_cont(vga_cont), 
		.Keypad_rows(Keypad_rows), 
		.Keypad_cols(Keypad_cols), 
		.Decoded_keyboard(Decoded_keyboard)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		Color = 0;
		Grid_Position = 0;
		SW = 0;
		EIs = 0;
		Keypad_rows = 0;
		
		// Wait 100 ns for global reset to finish
		#100;
		clk = 1;
		#100;
		
		clk = 0;
		
		// Add EIs stimulus
		rst = 1;
		SW = 8'b01010101;
		EIs = 1;
		
		#100;
		// Resulting sw_pos should be 01010101;
		
		// Set Colors and Grid Position
		Color = 128;
		Grid_Position = 128;
		Keypad_rows = 4'b0101;
		
		#100;
		
		Color = 64;
		
		
		// Set Clock Loop
		forever #50 clk = ~clk;
		
		   
		
		

	end
      
endmodule

