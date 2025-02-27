
module clk_gen(
    input clk_in_100M,
    output reg clk_out_25M,
    output reg clk_out_1k
    );

	reg [19:0] count_bit = 0;
	
	reg count_bit_1 = 0;	
	
	always @(posedge clk_in_100M)	begin
		count_bit = count_bit + 1;
		if (count_bit == 19'b1011111010111100001) begin
			clk_out_1k = ~clk_out_1k;
			count_bit = 0;
		end
	end
	
	always @(posedge clk_in_100M)
	begin
		count_bit_1 = ~ count_bit_1;
		if (~count_bit_1)
			clk_out_25M = ~clk_out_25M;
	end
	
	
endmodule
