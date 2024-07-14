
module mcu_io(
	 input clk,  // Clock
	 input rst,// Reset signal
	 
	 input [7:0] Color, // Data in
	 input [7:0] Grid_Position, // Data address
	 
	 output reg [7:0] sw_pos, // Position of the switches to the input port of the MCU
	 
	 input [7:0] SW, // Switch 0 to 7 on the board
	 input EIs,  // BTND on the board
	 
	 output [9:0] vga_cont, // Controlling signals to VGA
	 
	 input [3:0] Keypad_rows, // Connection to keypad matrix 4x4, inputs
	 output [3:0] Keypad_cols, // Connection to keypad matrix 4x4, outputs
	 output reg [7:0] Decoded_keyboard  // decoded value of the keyboard	  
    );
 
	 wire clk_25M;
	 wire clk_1k;
	 wire [3:0] KB;

	clk_gen CLK_GEN( .clk_in_100M (clk),
            .clk_out_25M (clk_25M),
				.clk_out_1k (clk_1k)  );
	 	 
	vga_out VGA_OUT(.clk(clk_25M),
			  .position(Grid_Position),
			  .color(Color),
			  .vgaRed(vga_cont[9:7]),
			  .vgaGreen(vga_cont[6:4]),
			  .vgaBlue(vga_cont[3:2]),
			  .Hsync(vga_cont[1]),
			  .Vsync(vga_cont[0])    );
	 
	keypad4x4 KYPAD( .clk(clk_1k),
				.rows(Keypad_rows),
				.cols(Keypad_cols),
				.D_KB(KB)      );

	 always @(EIs)
	 begin
		if (!rst)  begin
			sw_pos <= 8'd0;
			Decoded_keyboard <= 8'd0;
		end
		else begin
			sw_pos <= SW[7:0];
			Decoded_keyboard <= {4'b0000,KB};
		end
	 end

endmodule
