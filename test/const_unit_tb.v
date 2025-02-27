`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:16:35 03/16/2023
// Design Name:   const_unit
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/const_unit_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: const_unit
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module const_unit_tb;

	// Inputs
	reg [5:0] data_in;
	reg CS;

	// Outputs
	wire [7:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	const_unit uut (
		.data_in(data_in), 
		.CS(CS), 
		.data_out(data_out)
	);

	initial begin
		// Initialize Inputs
		data_in = 0;
		CS = 0;

		// Wait 100 ns for global reset to finish
		#100;

        CS = 1; // Sign-Extend Test
        data_in = 6'b000000; // 0
        #100;
        data_in = 6'b000001; // 1
        #100;
        data_in = 6'b000010; // 2
        #100;
        data_in = 6'b000100; // 4
        #100;
        data_in = 6'b001000; // 8
        #100;
        data_in = 6'b010000; // 16
        #100;
        data_in = 6'b100001; // -31
        #100;
        data_in = 6'b100010; // -30
        #100;
        data_in = 6'b100100; // -28
        #100;
        data_in = 6'b101000; // -24
        #100;
        data_in = 6'b110000; // -16
        #100;
        data_in = 6'b111111; // -1
        #100;

        
        CS = 0; // Zero-Extend Test
        data_in = 6'b000000; // 0
        #100;
        data_in = 6'b000001; // 1
        #100;
        data_in = 6'b000010; // 2
        #100;
        data_in = 6'b000100; // 4
        #100;
        data_in = 6'b001000; // 8
        #100;
        data_in = 6'b010000; // 16
        #100;
        data_in = 6'b100001; // 33
        #100;
        data_in = 6'b100010; // 34
        #100;
        data_in = 6'b100100; // 36
        #100;
        data_in = 6'b101000; // 40
        #100;
        data_in = 6'b110000; // 48
        #100;
        data_in = 6'b111111; // 63
        #100;

	end
      
endmodule

