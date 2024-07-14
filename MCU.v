module MCU(
   input rst,
   input clk,
   input [7:0] data_input,
   input [7:0] KB_input, // Keyboard input
   output [7:0] OUTPUT_LSB,
   output [7:0] OUTPUT_MSB
);

// Connect CPU, Data Memory, and Program Memory

// Wires

// CPU Output
wire [7:0] CPU_Address_DM;
wire [7:0] CPU_Address_IM;
wire [7:0] CPU_Data_out_DM;
wire CPU_MW;
// Data Memory Output
wire [7:0] DM_Data_Out;

// Program Memory (Instr Memory) Output
wire [16:0] IM_Instr_out; 

// Instantiate the CPU, Data Memory and Program Memory

CPU CPU1(
   .rst(rst),
   .main_clk(clk),
   .data_input(data_input),
   .KB_input(KB_input),
   .inst_in_IM(IM_Instr_out),
   .data_in_DM(DM_Data_Out),
   .OUT_MW(CPU_MW),
   .OUTPUT_LSB(OUTPUT_LSB),
   .OUTPUT_MSB(OUTPUT_MSB),
   .address_DM(CPU_Address_DM),
   .address_IM(CPU_Address_IM),
   .data_out_DM(CPU_Data_out_DM)
);

data_memory DM(
   .address_in_bus(CPU_Address_DM),
   .data_in_bus(CPU_Data_out_DM),
   .data_out_bus(DM_Data_Out),
   .MW(CPU_MW)
);

program_memory IM(
   .address_in_bus(CPU_Address_IM),
   .data_out_bus(IM_Instr_out)
);


endmodule