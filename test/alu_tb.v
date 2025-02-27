`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:04:41 03/16/2023
// Design Name:   alu
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/alu_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: alu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_tb;

	// Inputs
	reg [7:0] A;
	reg [7:0] B;
	reg [7:0] input_port_data;
	reg [7:0] input_port_kb;
	reg [3:0] function_select;
	reg [2:0] shift;

	// Outputs
	wire [7:0] F;
	wire C;
	wire Z;
	wire V;
	wire N;

	// Instantiate the Unit Under Test (UUT)
	alu uut (
		.A(A), 
		.B(B), 
		.input_port_data(input_port_data), 
		.input_port_kb(input_port_kb), 
		.function_select(function_select), 
		.shift(shift), 
		.F(F), 
		.C(C), 
		.Z(Z), 
		.V(V), 
		.N(N)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		input_port_data = 0;
		input_port_kb = 0;
		function_select = 0;
		shift = 0;

		// Wait 100 ns for global reset to finish
		#100;

      // Test 1a: ADD
      // FIXME: Remember to check for overflow and carry
      A = 8'b00001111; // 15
      B = 8'b00001111; // 15
      // Result: 30
      function_select = 4'b0000; // ADD
      #100;

      // Test 1b: ADD with negative numbers
      A = 8'b11110000; // -16
      B = 8'b11110000; // -16
      // Result: -32
      function_select = 4'b0000; // ADD
      #100;


      // Test 1c: ADD with overflow
      // Test 1d: ADD with carry
      // Test 1e: ADD with negative overflow
      // Test 1f: ADD with negative carry

      // Test 2a: SUB
      A = 8'b00001111; // 15
      B = 8'b00000111; // 7
      // Result: 8
      function_select = 4'b0001; // SUB
      #100;

      // Test 2b: SUB with negative numbers
      A = 8'b11110000; // -16
      B = 8'b11111000; // -8
      // Result: -8
      function_select = 4'b0001; // SUB

      // Test 2c: SUB with overflow
      // Test 2d: SUB with carry
      // Test 2e: SUB with negative overflow
      // Test 2f: SUB with negative carry

      // Test 3a: AND
      A = 8'b01011011; // 91
      B = 8'b01001011; // 75
      // Result in binary: 01001011
      function_select = 4'b0010; // AND
      #100;

      //Test 4a: OR
      A = 8'b11011011; // 219
      B = 8'b01001111; // 79
      // Result in binary: 11011111
      function_select = 4'b0011; // OR
      #100;

      // Test 5a: XOR
      A = 8'b11001010; // 202
      B = 8'b01001101; // 77
      // Result in binary: 10000111
      function_select = 4'b0100; // XOR
      #100;

      // Test 6a: NOT
      A = 8'b01001110; // 78
      // Result in binary: 10110001
      function_select = 4'b0101; // NOT
      #100;

      // Test 7a: SL
      A = 8'b00001111; // 15
      shift = 3'b001; // 1
      // Result in binary: 00011110
      function_select = 4'b0110; // SL
      #100;

      // Test 7b: SL
      A = 8'b00001111; // 15
      shift = 3'b011; // 3
      // Result in binary: 01111000 
      function_select = 4'b0110; // SL
      #100;

      // Test 8a: SR
      A = 8'b11110000; // -16
      shift = 3'b001; // 1
      // Result in binary: 01111000

      // Test 8b: SR
      A = 8'b11110000; // -16
      shift = 3'b011; // 3
      // Result in binary: 00011110

      // Test 9a: CMP Zero
      A = 8'b00000000; // 0
      B = 8'b00000000; // 0
      // Result: Z = 1
      function_select = 4'b0111; // CMP
      #100;

      // Test 9b: CMP Zero (not true)
      A = 8'b00000000; // 0
      B = 8'b00000001; // 1
      // Result: Z = 0
      function_select = 4'b0111; // CMP
      #100;

      // Test 10c: CMP
      A = 8'b00001111; // 15
      B = 8'b00000111; // 7
      // Result: 0
      function_select = 4'b0111; // CMP
      #100;

      // Test 10d: CMP
      A = 8'b00000111; // 7
      B = 8'b00001111; // 15
      // Result: 1
      function_select = 4'b0111; // CMP
      #100;

		
        
		// Add stimulus here

	end
      
endmodule

