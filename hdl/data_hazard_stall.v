`timescale 1ns / 1ps

module data_hazard_stall (
   input DOF_EX_RW, // Read-Write for the EX stage
   input [REG_ADDRESS_WIDTH-1:0]  DOF_EX_DA, // Destination Address for the EX stage
   input [REG_ADDRESS_WIDTH-1:0] AA, // Address for Register A from ID Stage
   input [REG_ADDRESS_WIDTH-1:0] BA, // Address for Register B from ID Stage
   input MA, // MA input signal from ID Stage
   input MB, // MB input signal from ID Stage
   output reg DHS // Data Hazard Stall
);


   parameter REG_ADDRESS_WIDTH = 3;

   reg comp_AA_DA; // Result from comparing AA and DA
   reg comp_BA_DA; // Result from comparing BA and DA
   reg HB; // Data hazard for register B
   reg HA; // Data hazard for register A
   reg DA_nz;  // Check if DA is not R0

   always @ (*)
   begin
      // Compare AA and DA and output 1 if equal into comp_AA_DA
      comp_AA_DA = (AA == DOF_EX_DA) ? 1'b1 : 1'b0;
      // Compare BA and DA and output 1 if equal into comp_BA_DA
      comp_BA_DA = (BA == DOF_EX_DA) ? 1'b1 : 1'b0;

      // Check if DA is not R0 by ORing all the bits in DA
      DA_nz = DOF_EX_DA[REG_ADDRESS_WIDTH-1] | DOF_EX_DA[REG_ADDRESS_WIDTH-2] | DOF_EX_DA[REG_ADDRESS_WIDTH-3];

      // Check if there is a data hazard for register B
      HB = (comp_BA_DA & !MB & DOF_EX_RW & DA_nz) ? 1'b1 : 1'b0;

      // Check if there is a data hazard for register A
      HA = (comp_AA_DA & !MA & DOF_EX_RW & DA_nz) ? 1'b1 : 1'b0;

      DHS = (HB | HA) ? 1'b1 : 1'b0; // Final output for data hazard stall
   end


endmodule

      