`timescale 1ns / 1ps
module branch_detect(
   input PS, // Zero Toggle
   input Z, // Zero Flag
   input [1:0] BS, // branch select
   output reg [1:0] muxCSel, 
   output reg br_detect // 
);


   always @ (*)
   begin
      muxCSel[1] <= BS[1];
      muxCSel[0] <= ((PS ^ Z) | BS[1]) & BS[0];
      br_detect = muxCSel[1] | muxCSel[0];
   end

endmodule