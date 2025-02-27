`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:40:52 03/25/2023
// Design Name:   MCU
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/MCU_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MCU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MCU_tb;

	// Inputs
	reg rst;
	reg clk;
	reg [7:0] data_input;
	reg [7:0] KB_input;

	// Outputs
	wire [7:0] OUTPUT_LSB;
	wire [7:0] OUTPUT_MSB;

	// Instantiate the Unit Under Test (UUT)
	MCU uut (
		.rst(rst), 
		.clk(clk), 
		.data_input(data_input), 
		.KB_input(KB_input), 
		.OUTPUT_LSB(OUTPUT_LSB), 
		.OUTPUT_MSB(OUTPUT_MSB)
	);



	integer i;
		
	initial begin
		// Initialize Inputs
		rst = 0; // Active Low Reset
		clk = 0;
		data_input = 0;
		KB_input = 0;
		#100;
		
		clk = ~clk;
		#100;
		
		// After Reset
		
		
		clk = 0;
		#100;
		clk = 0;
		
		data_input = 16; 
		KB_input = 32;
		rst = 1; // Deactivate Reset
		
		// OUTPUT_LSB Should be 32
		// OUTPUT_MSB should be 16
		
		// Will be updated as program loops, and values will be changed due to the previous program.
		
		// Program runs due to do forever loop
		forever #50 clk = ~clk;
		
		
		
		

	end
      
endmodule

