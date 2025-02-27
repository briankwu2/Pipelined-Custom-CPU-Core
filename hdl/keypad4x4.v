
module keypad4x4(
    clk,
    rows,
    cols,
    D_KB
    );

input clk;
input [3:0] rows;
output reg [3:0] cols;
output reg [3:0] D_KB;

parameter s0=4'b0111;
parameter s1=4'b1011;
parameter s2=4'b1101;
parameter s3=4'b1110;

reg [1:0] state, next_state;

always @(*) begin
case (state)
	2'b00: begin cols <= s0; next_state <= 2'b01; end
	2'b01: begin cols <= s1; next_state <= 2'b10; end
	2'b10: begin cols <= s2; next_state <= 2'b11; end
	2'b11: begin cols <= s3; next_state <= 2'b00; end
endcase
end

always @( posedge clk ) begin
state <= next_state; end

always @(posedge clk)
begin
	if (cols == s0) begin
		if (rows == s0) D_KB <= 4'b1111;
		else if (rows == s1) D_KB <= 4'b1011;
		else if (rows == s2) D_KB <= 4'b0111; 
		else if (rows == s3) D_KB <= 4'b0011; 
		end
	else if (cols == s1) begin
		if (rows == s0) D_KB <= 4'b1110;
		else if (rows == s1) D_KB <= 4'b1010;
		else if (rows == s2) D_KB <= 4'b0110; 
		else if (rows == s3) D_KB <= 4'b0010; 
		end
	else if (cols == s2) begin
		if (rows == s0) D_KB <= 4'b1101; 
		else if (rows == s1) D_KB <= 4'b1001; 
		else if (rows == s2) D_KB <= 4'b0101; 
		else if (rows == s3) D_KB <= 4'b0001; 
		end
	else if (cols == s3) begin
		if (rows == s0) D_KB <= 4'b1100;
		else if (rows == s1) D_KB <= 4'b1000; 
		else if (rows == s2) D_KB <= 4'b0100;
		else if (rows == s3) D_KB <= 4'b0000; 
		end
end

endmodule
