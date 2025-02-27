`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:32:36 03/16/2023 
// Design Name: 
// Module Name:    data_memory 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module data_memory(
 	input [DATA_ADDRESS_WIDTH - 1:0] address_in_bus,
   input [DATA_WIDTH - 1:0] data_in_bus,
   output reg [DATA_WIDTH - 1:0] data_out_bus,
   input MW
   );
	
	parameter DATA_ADDRESS_WIDTH = 8;
	parameter DATA_WIDTH = 8;
	parameter NUM_ADDRESSES = 256;

	 
	reg [DATA_WIDTH - 1:0] data_reg [NUM_ADDRESSES - 1:0];
	 
	
	always @ (*)
	begin
		if (MW == 0)
			data_out_bus <= data_reg[address_in_bus];
		else if (MW == 1)
			data_reg[address_in_bus] <= data_in_bus;
	end
	 



endmodule
