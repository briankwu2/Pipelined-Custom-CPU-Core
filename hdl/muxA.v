`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:00:03 03/16/2023 
// Design Name: 
// Module Name:    muxA 
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
module muxA (
    input [MUX_BIT_WIDTH-1:0] data_0,
    input [MUX_BIT_WIDTH-1:0] data_1,
    input sel,
    output reg [MUX_BIT_WIDTH-1:0] data_out
);

	
	parameter MUX_BIT_WIDTH = 8;

	// Case Statement for MUX Logic

	always @ (*)
	begin
		 case(sel)
			  0: data_out = data_0;
			  1: data_out = data_1;
		 endcase
	end
endmodule