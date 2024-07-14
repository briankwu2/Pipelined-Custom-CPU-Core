`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:36:30 03/16/2023
// Design Name:   data_memory
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/data_memory_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: data_memory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module data_memory_tb;

	// Inputs
	reg [7:0] address_in_bus;
	reg [7:0] data_in_bus;
	reg read_not_write;

	// Outputs
	wire [7:0] data_out_bus;

	// Instantiate the Unit Under Test (UUT)
	data_memory UUT (
		.address_in_bus(address_in_bus), 
		.data_in_bus(data_in_bus), 
		.data_out_bus(data_out_bus), 
		.read_not_write(read_not_write)
	);

	initial begin
	// Initialize Inputs
		address_in_bus = 0;
		data_in_bus = 0;
		read_not_write = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Write 0x50 to the address 0x10.
		read_not_write = 0;
		address_in_bus <= 8'h10;
		data_in_bus <= 8'h50;
		#100;
		
		// Read and see what the output of data_out_bus.
		read_not_write = 1;
		#100;
		
		
		// Write 0x30 to the address 0x10
		read_not_write = 0;
		data_in_bus <= 8'h30;
		
		#100;
		
		// See if the memory was overwritten
		read_not_write = 1;
		
	end
      
endmodule

