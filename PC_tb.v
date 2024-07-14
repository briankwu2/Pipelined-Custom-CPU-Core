// DEPRECATED: This file is no longer used. It is kept for reference only. PC has changed due to the logic of CPU/ PC has changed due to the logic of CPU.v
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:36:06 03/18/2023
// Design Name:   PC
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/PC_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PC_tb;

	// Inputs
	reg clk;
	reg reset;
	reg load_enable;
	reg [7:0] PC_in;

	// Outputs
	wire [7:0] PC_out;

	// Instantiate the Unit Under Test (UUT)
	PC uut (
		.clk(clk), 
		.reset(reset), 
		.load_enable(load_enable), 
		.PC_in(PC_in), 
		.PC_out(PC_out)
	);

   always #50 clk = ~clk; // Looping clock
   integer i; // For looping

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0; // Active Low Reset
		load_enable = 0;
		PC_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
      reset = 1; // In order to not reset
		load_enable = 1;
		
  
      // Test 2a: Does the PC get written by the PC_in when load_enable is high?
      load_enable = 1;
      PC_in = 5;
      #100;
      $display("PC_out = %b", PC_out);

      // Test 2b: Test 2a again, but with a different value
      load_enable = 1;
      PC_in = 10;
      $display("PC_out = %b", PC_out);
      #100;
		
		// Test 3: Does PC maintain itself when load_enable is low?
		load_enable = 0;
		PC_in = 50;
		#100;
		PC_in = 30;
		#100;
		PC_in = 15;
		#100;
		

      // Test 3: Does the PC get reset to 0 when reset is active?
      reset = 0;
      #100;
      $display("PC_out = %b", PC_out);

        

	end
      
endmodule

