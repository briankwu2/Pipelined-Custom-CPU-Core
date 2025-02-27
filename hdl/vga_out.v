
module vga_out(
    input clk,
    input [7:0] position,
    input [7:0] color,
    output [2:0] vgaRed,
    output [2:0] vgaGreen,
    output [2:1] vgaBlue,
    output Hsync,
    output Vsync
    );
	 
	 // Pixel and color control
	 wire [9:0] x_pos;
	 wire [9:0] y_pos;
	 wire [2:0] redIn;
	 wire [2:0] greenIn;
	 wire [2:1] blueIn;
	 
	 wire [1:0] grid_x;
	 wire [1:0] grid_y;
	 
	 // Memory to store color of each segment
	 reg [7:0] color_mem [0:15];
	  
	 // Set output color
	 assign {redIn, greenIn, blueIn[2:1]} = color_mem[{grid_y, grid_x}];
	 
	 VGA_driver VGA_MOD(.clk_25M(clk),
							 .redIn(redIn),
							 .greenIn(greenIn),
							 .blueIn(blueIn[2:1]),
							 .vgaRed(vgaRed),
							 .vgaGreen(vgaGreen),
							 .vgaBlue(vgaBlue),
							 .Hsync(Hsync),
							 .Vsync(Vsync),
							 .x_pos(x_pos),
							 .y_pos(y_pos)
							 );
	vga_grid16 VGA_GRID(.x_pos(x_pos),.y_pos(y_pos),.grid_x(grid_x),.grid_y(grid_y));
	
	always @(negedge clk)
	begin
		color_mem[position] <= color;
	end

endmodule
