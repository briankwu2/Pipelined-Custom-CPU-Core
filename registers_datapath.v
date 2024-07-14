`timescale 1ns / 1ps

/*
   This module is a combination of all the registers that need to hold data between pipeline
   stages.
   Each register has a positive edge clock, and an active low reset signal.
   Some registers may have a load enable signal, which will load the register with the value when it is active high only.
   If load enable is not used, then the register will retain its value.
   Other registers will always update their value on the positive edge clock.

*/

// Holds the Program Address, does not count due to the more complex logic of the CPU.
// Counting logic is added in the CPU implementation
module PC (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input load_enable, // Load enable
      input [ADDRESS_WIDTH-1:0] PC_in, // PC input
      output reg [ADDRESS_WIDTH-1:0] PC_out // PC output
   );

	parameter ADDRESS_WIDTH = 8;

   // For the program counter, every clock cycle, 
   // If the load_enable is high, then the PC will be loaded with the value of PC_in
   // The value of PC_in is controlled by the muxC_out signal, and includes any branch addresses or the next instruction address (PC+1)
   // If the reset is low, then the PC will be loaded with 0
   // The PC will be 8 bits wide

   always @(posedge clk) begin
      if (reset == 0) begin
         PC_out <= 0;
      end
      else if (load_enable == 1) begin // Branching will be done by loading the PC with the value of the branch address (PC_in)
         PC_out <= PC_in;
      end
		
   end

endmodule

module IR (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input load_enable, // Load enable
      input [IR_WIDTH-1:0] IR_in, // IR input
      output reg [IR_WIDTH-1:0] IR_out // IR output
   );

   parameter IR_WIDTH = 17;

   // For the instruction register, every clock cycle, it will be loaded with the value of the instruction at the address of the PC
   // If the load_enable is high, then the IR will be loaded with the value of IR_in
   // If the reset is low, then the IR will be loaded with 0
   // The IR will be 17 bits wide

   always @(posedge clk)
   begin
      if (reset == 0) begin
         IR_out <= 0;
      end
      else if (load_enable == 1) begin
         IR_out <= IR_in;
      end


   end

endmodule


// Keeps some of the instruction signals from the ID
module IR_DOF_TO_EX (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input RW,
      input [2:0] DA,
      input [1:0] MD,
      input [1:0] BS,
      input PS,
      input MW,
      input [3:0] FS,
      input [2:0] SH,
      input OE,
      // Any EX Prefix signals are for the EX stage
      output reg EX_RW,
      output reg [2:0] EX_DA,
      output reg [1:0] EX_MD,
      output reg [1:0] EX_BS,
      output reg EX_PS,
      output reg EX_MW,
      output reg [3:0] EX_FS,
      output reg [2:0] EX_SH,
      output reg EX_OE
   );

   //
	always @ (posedge clk)
	begin
		if (reset == 0)
		begin
			EX_RW <= 0;
			EX_DA <= 0;
			EX_MD <= 0;
			EX_BS <= 0;
			EX_PS <= 0;
			EX_MW <= 0;
			EX_FS <= 0;
			EX_SH <= 0;
			EX_OE <= 0;
		end
		else begin
			EX_RW <= RW;
			EX_DA <= DA;
			EX_MD <= MD;
			EX_BS <= BS;
			EX_PS <= PS;
			EX_MW <= MW;
			EX_FS <= FS;
			EX_SH <= SH;
			EX_OE <= OE;
		end
	end
	

endmodule

module mux_bus(
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input [BUS_A_WIDTH-1:0] bus_in, // input
      output reg [BUS_A_WIDTH-1:0] bus_out // output
   );

   parameter BUS_A_WIDTH = 8; 

   // For the bus  every clock cycle, it will be loaded with the value of the instruction
   // If the reset is low, then the bus will be loaded with 0
   // The bus will be 8 bits wide

   always @(posedge clk)
   begin
      if (reset == 0) begin
         bus_out <= 0;
      end
      else begin
         bus_out <= bus_in;
      end
   end

endmodule


module IR_EX_TO_WB (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input RW,
      input [2:0] DA,
      input [1:0] MD,
      output reg WB_RW,
      output reg [2:0] WB_DA,
      output reg [1:0] WB_MD
   );


   // For the pipeline register, every clock cycle, it will be loaded with the value of the input
   // If the reset is low, then the register will be loaded with 0

   always @(posedge clk)
   begin
      if (reset == 0) begin
         WB_RW <= 0;
         WB_DA <= 0;
         WB_MD <= 0;
      end
      else begin
         WB_RW <= RW;
         WB_DA <= DA;
         WB_MD <= MD;
      end
   end

endmodule



module OUT_MSB (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input load_enable, // Load enable
      input [OUT_MSB_WIDTH-1:0] data_in, // input
      output reg [OUT_MSB_WIDTH-1:0] data_out// output
   );

   parameter OUT_MSB_WIDTH = 8; 

   // For the register, every clock cycle, it will be loaded with the value of the OUT_MSB   
   // If the load_enable is high, then the register will be loaded with the value of data_in
   // If the reset is low, then the register will be loaded with 0
   // The register will be 8 bits wide

   always @(posedge clk)
   begin
      if (reset == 0) begin
         data_out <= 0;
      end
      else if (load_enable == 1) begin
         data_out <= data_in;
      end
   end


endmodule

module OUT_LSB (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input load_enable, // Load enable
      input [OUT_LSB_WIDTH-1:0] data_in, // input
      output reg [OUT_LSB_WIDTH-1:0] data_out// output
   );

   parameter OUT_LSB_WIDTH = 8; 

   // For the register, every clock cycle, it will be loaded with the value of the OUT_LSB   
   // If the load_enable is high, then the register will be loaded with the value of data_in
   // If the reset is low, then the register will be loaded with 0
   // The register will be 8 bits wide

   always @(posedge clk)
   begin
      if (reset == 0) begin
         data_out <= 0;
      end
      else if (load_enable == 1) begin
         data_out <= data_in;
      end
   end


endmodule


module D_BIT (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input  data_in, // input
      output reg data_out// output
   );


   // Holds the value of the D bit
   always @(posedge clk)
   begin
      if (reset == 0) begin
         data_out <= 0;
      end
      else begin
         data_out <= data_in;
      end
   end


endmodule


module F_RESULT (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input [F_RESULT_WIDTH-1:0] data_in, // input
      output reg [F_RESULT_WIDTH-1:0] data_out// output
   );

   parameter F_RESULT_WIDTH = 8; 

   // For the register, every clock cycle, it will be loaded with the value of the F_RESULT   
   // If the reset is low, then the register will be loaded with 0


   always @(posedge clk)
   begin
      if (reset == 0) begin
         data_out <= 0;
      end
      else begin
         data_out <= data_in;
      end
   end

endmodule


module data_mem_reg (
      input clk, // Posedge Pulsed
      input reset, // Active Low
      input [DATA_MEM_WIDTH-1:0] data_in, // input
      output reg [DATA_MEM_WIDTH-1:0] data_out// output
   );

   parameter DATA_MEM_WIDTH = 8; 

   // For the register, every clock cycle, it will be loaded with the value of the data memory   
   // If the reset is low, then the register will be loaded with 0
   // The register will be 8 bits wide

	always @ (posedge clk)
	begin
		if (reset == 0) begin
			data_out <= 0;
		end
		else begin
			data_out <= data_in;
		end
	end
	
endmodule



