`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:55:34 03/16/2023
// Design Name:   register
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/register_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module register_tb;

	// Inputs
	reg [2:0] AA;
	reg [2:0] BA;
	reg [2:0] DA;
	reg [7:0] data_in;
	reg WR;
	reg clk;
	reg rst;

	// Outputs
	wire [7:0] data_a;
	wire [7:0] data_b;

	// Instantiate the Unit Under Test (UUT)
	register uut (
		.AA(AA), 
		.BA(BA), 
		.DA(DA), 
		.data_in(data_in), 
		.WR(WR), 
		.clk(clk), 
		.rst(rst), 
		.data_a(data_a), 
		.data_b(data_b)
	);

	always #50 clk = ~clk;
   
   integer i;
	initial begin
		// Initialize Inputs
		AA = 0;
		BA = 0;
		DA = 0;
		data_in = 0;
		WR = 0;
		rst = 0;
		clk = 0;
      #100;

     
      // Set writing option
      WR = 1;
		rst = 1; // Deactivate Reset 
		
      // Test 1: Write to Register 1
      DA = 3'b001; // Write to R1
      data_in = 8'b00000101; // Write 5 to R1
      #100;

      // Test 2: Write to Register B
      DA = 3'b010; // Write to R2
      data_in = 8'b00001010; // Write 10 to R2
      #100;

      // Test 3: Read from register A and B
      AA = 3'b001; // Read from R1
      BA = 3'b010; // Read from R2
      WR = 0; // Read Option
      #100;

      //--------------------------------------------------------------------------------
      WR = 1; // Write Option

      //Test 4: Rewrite different values to registers and read from register A and register B
      DA = 3'b001; // Write to R1
      data_in = 8'b00000001; // Write 1 to R1
      #100;

      DA = 3'b010; // Write to R2
      data_in = 8'b00000010; // Write 2 to R2
      #100;

      AA = 3'b001; // Read from R1
      BA = 3'b010; // Read from R2
      WR = 0; // Read Option
      #100;

      //--------------------------------------------------------------------------------
      // Test 5: Check if you can write to register 0 (you shouldn't be able to)
      WR = 1; // Write Option
      DA = 3'b000; // Write to R0

      data_in = 8'b11111111; // Write 255 to R0
      #100;

      //Read from R0
      AA = 3'b000; // Read from R0
      BA = 3'b000; // Read from R0
      WR = 0; // Read Option
      #100;

      //--------------------------------------------------------------------------------
      // Test 6: Test if rst works
      rst = 0; // Reset
      #100;

      // Read from registers R0 to R7, should all be 0.
      for (i = 0; i < 8; i = i + 1) begin
         AA = i; // Read from R0 to R7
         BA = i; // Read from R0 to R7
         WR = 0; // Read Option
         #100;
      end


	end
      
endmodule

