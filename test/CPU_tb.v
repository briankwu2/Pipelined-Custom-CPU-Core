`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:38:48 03/25/2023
// Design Name:   CPU
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/CPU_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CPU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module CPU_tb;

	// Inputs
	reg rst;
	reg main_clk;
	reg [7:0] data_input;
	reg [7:0] KB_input;
	reg [16:0] inst_in_IM;
	reg [7:0] data_in_DM;

	// Outputs
	wire OUT_MW;
	wire [7:0] OUTPUT_LSB;
	wire [7:0] OUTPUT_MSB;
	wire [7:0] address_DM;
	wire [7:0] address_IM;
	wire [7:0] data_out_DM;

	// Instantiate the Unit Under Test (UUT)
	CPU uut (
		.rst(rst), 
		.main_clk(main_clk), 
		.data_input(data_input), 
		.KB_input(KB_input), 
		.inst_in_IM(inst_in_IM), 
		.data_in_DM(data_in_DM), 
		.OUT_MW(OUT_MW), 
		.OUTPUT_LSB(OUTPUT_LSB), 
		.OUTPUT_MSB(OUTPUT_MSB), 
		.address_DM(address_DM), 
		.address_IM(address_IM), 
		.data_out_DM(data_out_DM)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		main_clk = 0;
		data_input = 0;
		KB_input = 0;
		inst_in_IM = 0;
		data_in_DM = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

