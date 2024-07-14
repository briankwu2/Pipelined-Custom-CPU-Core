`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:53:30 03/15/2023 
// Design Name: 
// Module Name:    const_unit 
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
module const_unit(
    input [IMMEDIATE_WIDTH-1:0] data_in,
    input CS,
    output reg [ALU_OPERAND_WIDTH-1:0] data_out
);

	parameter IMMEDIATE_WIDTH = 6;
	parameter ALU_OPERAND_WIDTH = 8;
	parameter SIGN_EXTEND_WIDTH = ALU_OPERAND_WIDTH - IMMEDIATE_WIDTH;

	parameter DATA_WIDTH = 8;
	always @ (*)
	begin
		 if (CS == 0) // Zero-Extend
			  data_out[DATA_WIDTH-1:0] = {{2{1'b0}}, {data_in[IMMEDIATE_WIDTH-1:0]}}; // Pads left side with zeroes
		 else if (CS == 1) // Sign-Extend
			  data_out[DATA_WIDTH-1:0] = {{2{data_in[IMMEDIATE_WIDTH-1]}}, {data_in[IMMEDIATE_WIDTH-1:0]}};
	end



endmodule
