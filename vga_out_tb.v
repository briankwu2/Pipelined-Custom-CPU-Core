`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:39:24 04/09/2023
// Design Name:   vga_out
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/vga_out_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_out
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_out_tb;

	// Inputs
	reg clk;
	reg [7:0] position;
	reg [7:0] color;

	// Outputs
	wire [2:0] vgaRed;
	wire [2:0] vgaGreen;
	wire [2:1] vgaBlue;
	wire Hsync;
	wire Vsync;

	// Instantiate the Unit Under Test (UUT)
	vga_out uut (
		.clk(clk), 
		.position(position), 
		.color(color), 
		.vgaRed(vgaRed), 
		.vgaGreen(vgaGreen), 
		.vgaBlue(vgaBlue), 
		.Hsync(Hsync), 
		.Vsync(Vsync)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		position = 0;
		color = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		position = 8'b1111111;
		color = 8'b1111111;
		
		forever #50 clk = ~clk;
        
		// Add stimulus here

	end
      
endmodule

