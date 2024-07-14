module branch_adder(
   input [7:0] A,
   input [7:0] B,
   output reg [7:0] BrA
);

always @ (*)
begin
   BrA = A + B;
end

endmodule