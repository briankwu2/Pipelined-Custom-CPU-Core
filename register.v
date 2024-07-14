`timescale 1ns / 1ps
module register(
	input [REG_ADDRESS_SIZE - 1:0] AA, // Address of Register A
	input [REG_ADDRESS_SIZE - 1:0] BA, // Address of Register B
	input [REG_ADDRESS_SIZE - 1:0] DA, // Data_In Port Register
	input [REG_DATA_WIDTH - 1:0] data_in,
	input WR, // Read-Write Flag, WR == 1 is write, WR == 0 is read
	input clk,
	input rst, // Active Low
	output [REG_DATA_WIDTH - 1:0] data_a,
	output [REG_DATA_WIDTH - 1:0] data_b
);

	parameter REG_ADDRESS_SIZE = 3;
	parameter REG_SIZE = 8;
	parameter REG_DATA_WIDTH = 8;

	integer i; // for looping

	// Internal Variables
	reg [REG_DATA_WIDTH-1:0] regFile [REG_SIZE-1:0];

	
	initial begin
		regFile[0] <= 'b0; // Assigns R0 as 0.
	end
	
	// Register Logic
	always @ (posedge clk) // Write on the positive edge
	begin
		#3; // Is needed for making it write without a 1 clock delay (how to prevent this in the future without this?)
		if(WR == 1 && DA != 3'b000 && rst == 1) // Write Operation | Prevents R0 being written to
		begin
			  regFile[DA] <= data_in; // Writes the data_in into the data address (DA) 
		end
		else if (rst == 0)
		begin
			for (i = 0 ; i < REG_SIZE; i = i + 1) 
			begin
				regFile[i] <= 0;
			end
		end
	
	end
	
	assign data_a = regFile[AA];
	assign data_b = regFile[BA];
	
	
	
	
endmodule