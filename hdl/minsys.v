`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:43:23 03/24/2023 
// Design Name: 
// Module Name:    minsys 
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
module minsys(
	input clk,
	input rst,
	input EI,
	input [7:0] SW,
	output [9:0] vga_cont,
	input [3:0] Keypad_rows,
	output [3:0] Keypad_cols
   );

	// Wires
	wire [7:0] sw_pos_mcu_io;
	wire [7:0] Decoded_keyboard_mcu_io;
	wire [7:0] OUTPUT_MSB_MCU;
	wire [7:0] OUTPUT_LSB_MCU;
		
	MCU mcu1(
		.rst(rst),
		.clk(clk),
		.data_input(sw_pos_mcu_io),
		.KB_input(Decoded_keyboard_mcu_io),
		.OUTPUT_LSB(OUTPUT_LSB_MCU),
		.OUTPUT_MSB(OUTPUT_MSB_MCU)
	);	
	
	mcu_io mcu_io_1 (
		.clk(clk),
		.rst(rst),
		.Color(OUTPUT_LSB_MCU),
		.Grid_Position(OUTPUT_MSB_MCU),
		.sw_pos(sw_pos_mcu_io), // Output
		.SW(SW), //Input
		.EIs(EI),
		.vga_cont(vga_cont),
		.Keypad_rows(Keypad_rows),
		.Keypad_cols(Keypad_cols),
		.Decoded_keyboard(Decoded_keyboard_mcu_io)
		);
	

		


endmodule
