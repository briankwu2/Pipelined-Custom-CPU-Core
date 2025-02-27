`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:00:00 03/16/2023
// Design Name:   muxD
// Module Name:   /home/010/b/bk/bkw180001/Desktop/CE6302_Project1/muxD_tb.v
// Project Name:  CE6302_Project1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: muxD
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module muxD_tb;

	// Inputs
	reg [0:0] data_0;
	reg [0:0] data_1;
	reg [0:0] data_2;
	reg [1:0] sel;

	// Outputs
	wire [0:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	muxD uut (
		.data_0(data_0), 
		.data_1(data_1), 
		.data_2(data_2), 
		.sel(sel), 
		.data_out(data_out)
	);

	integer i;
	initial begin
		// Initialize Inputs
		data_0 = 0;
		data_1 = 0;
		data_2 = 0;
		sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		
		// First Batch of Values (100), 
		data_0 = 1;
		data_1 = 0;
		data_2 = 0;
		
		
		
		for (i = 0; i < 3; i = i+1)
		begin
            sel <= i;
            #100;
		end

	    // Second Batch of Values (010),
        data_0 = 0;
        data_1 = 1;
        data_2 = 0;

        for (i = 0; i < 3; i= i+1)
		begin
			sel = i;
			#100;
		end
		

        // Third Batch of Values (001),
        data_0 = 0;
        data_1 = 0;
        data_2 = 1;

        for (i = 0; i < 3; i= i+1)
		begin
            sel = i;
            #100;
		end


        // Testing for sel 11 for z value

        sel = 3;
        #100;

        // Simulation ends here
        

	end
      
endmodule

