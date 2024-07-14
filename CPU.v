module CPU (
   input rst,
   input main_clk,
   input [7:0] data_input,
   input [7:0] KB_input, // Keyboard input
   input [16:0] inst_in_IM, // Instruction line from instruction memory
   input [7:0] data_in_DM, // Data line from data memory
	output OUT_MW, // memory write for data memory
   output [7:0] OUTPUT_LSB,
   output [7:0] OUTPUT_MSB,
   output [7:0] address_DM, // Address line to data memory
   output [7:0] address_IM, // Address line to instruction memory
   output [7:0] data_out_DM // Data line to data memory
);

// Connect all the submodules together in the CPU


// Wires, organized by stage as much as possible
// IF Wires
wire br_detect;
wire br_detect_neg;
wire [1:0] muxC_sel;
wire [7:0] muxC_out; 
wire [7:0] RAA; // Register A Address?
wire [7:0] PC; // Output of PC
wire [7:0] PC_next; // Output of PC + 1 
wire [7:0] PC_prev1; // Output of PC_prev1
wire [7:0] PC_prev2; // Output of PC_prev2
wire [16:0] IR; // Output of instruction register
wire DHS; // Data Hazard Stall
wire DHS_neg; // Data Hazard Stall Negated
wire PS; // Zero Toggle
wire [1:0] BS; // Branch Select

// Branch Adder
wire [7:0] BrA;

wire ZF; // Zero flag from ALU
// WB Stage Wires for RW and DA
wire WB_RW;
wire [2:0] WB_DA;

// DOF-EX Pipeline register (needs to be declared before instantiation due to size issues?)
wire [1:0] EX_BS; // Branch Select *implicitly declared by module instantiation
wire EX_PS; // Zero Toggle *see above

// Mux D
wire [7:0] bus_D;


assign DHS_neg = ~DHS; 
assign br_detect_neg = ~br_detect;
assign PC_next = PC + 8'b1; // Counts for PC

// IF Stage 
// Connect the branch_detect, muxC, PC,PC-1, PC-2, and instruction register together. 
// Includes logic to add 1 to the PC, through sel 0 of muxC 

branch_detect branch_detect1(
   .PS(EX_PS),
   .Z(ZF),
   .BS(EX_BS),
   .muxCSel(muxC_sel),
   .br_detect(br_detect)
);

muxC muxC1(
   .data_0(PC_next),
   .data_1(BrA), 
   .data_2(RAA),
   .data_3(BrA),
   .sel(muxC_sel),
   .data_out(muxC_out)
);

PC PC_curr(
   .clk(main_clk),
   .reset(rst),
   .load_enable(DHS_neg), // 
   .PC_in(muxC_out),
   .PC_out(PC)
);

assign address_IM = PC; // Connect the address line to the instruction memory

PC PC_prev(
   .clk(main_clk),
   .reset(rst),
   .load_enable(DHS_neg), // 
   .PC_in(PC),
   .PC_out(PC_prev1)
);

PC PC_prev_prev(
   .clk(main_clk),
   .reset(rst),
   .load_enable(DHS_neg), // 
   .PC_in(PC_prev1),
   .PC_out(PC_prev2)
);

// Instruction Register
IR IR1(
   .clk(main_clk),
   .reset(rst),
   .load_enable(DHS_neg), // 
   .IR_in(inst_in_IM), // NEEDS LOGIC FOR FLUSHING BRANCH
   .IR_out(IR)
);


// DOF STAGE ---------------------------------------------------------

// Wires

// Instruction Decoder Wires
// The ID prefix is used on some of the wires to indicate that they need
// additional logic to be able to be output into the next pipeline register

wire [2:0] ID_DA; // Destination Address
wire [2:0] AA; // Register A Address
wire [2:0] BA;  // Register B Address
wire [1:0] ID_BS; // Branch Select

wire ID_MW; // Memory Write
wire ID_RW; // Register Write
wire MA; // MUXA Sel
wire MB; // MUXB Sel
wire [1:0] MD; // MUXD Sel
wire [3:0] FS; // Function Select (ALU Operation)
wire [2:0] SH; // Shift Amount
wire CS; // Constant unit select
wire OE; // Output Enable: enables writing data to output port

// Wires after logic
wire [2:0] DA; // Destination Address

wire RW; // Register Write

// Decode instruction and fetch any operands from the register file
// NOTE: ID slightly modified to include SH as an output rather than directly obtaining from
// IR register output like in the MUC diagram. Serves no functional difference.

instr_decoder ID (
   .instr_line(IR),
   .DA(ID_DA),
   .AA(AA),
   .BA(BA),
   .BS(ID_BS),
   .PS(PS),
   .MW(ID_MW),
   .RW(ID_RW),
   .MA(MA),
   .MB(MB),
   .MD(MD),
   .FS(FS),
   .SH(SH),
   .CS(CS),
   .OE(OE)
);

// Logic for additional wires
assign DA = ID_DA & {3{DHS_neg}} & {3{br_detect_neg}}; 
assign BS = ID_BS & {2{DHS_neg}} & {2{br_detect_neg}};
assign MW = ID_MW & DHS_neg & br_detect_neg;
assign RW = ID_RW & DHS_neg & br_detect_neg;

// Constant Unit (sign extender) --------------------------------------

// Wires
wire [5:0] IM; // Immediate value from IR register
wire [7:0] IM_extended; // extended or zero-extended immediate value

assign IM = IR[5:0]; // Obtains immediate from IR register
const_unit constant_unit1(
   .data_in(IM),
   .CS(CS),
   .data_out(IM_extended)
);

// Register File ------------------------------------------------------
// Wires
wire [7:0] data_a; // Data from register A
wire [7:0] data_b; // Data from register B

// Connect the register file to the CPU
register reg_file (
   .AA(AA),
   .BA(BA),
   .DA(WB_DA),
   .data_in(bus_D), 
   .WR(WB_RW), 
   .clk(main_clk),
   .rst(rst),
   .data_a(data_a),
   .data_b(data_b)
);

// MUX A & MUX B ------------------------------------------------------
// Wires
wire [7:0] busA; // Output of MUX A
wire [7:0] busB; // Output of MUX B

// Connect the MUX A and MUX B to the CPU
muxA muxA1(
   .data_0(data_a),
   .data_1(PC_prev1),
   .sel(MA),
   .data_out(busA)
);

muxB muxB1(
   .data_0(data_b),
   .data_1(IM_extended),
   .sel(MB),
   .data_out(busB)
);

// Pipeline register (DOF -> EX) --------------------------------------
// Wires
// The EX prefix is used to indicate that all the wires
// are output from the pipeline register (DOF_EX)
wire [2:0] EX_DA; // Destination Address
wire [2:0] EX_AA; // Register A Address
wire [2:0] EX_BA;  // Register B Address
wire EX_MW; // Memory Write
wire EX_RW; // Register Write
wire EX_MA; // MUXA Sel
wire EX_MB; // MUXB Sel
wire [1:0] EX_MD; // MUXD Sel
wire [3:0] EX_FS; // Function Select (ALU Operation)
wire [2:0] EX_SH; // Shift Amount
wire EX_CS; // Constant unit select
wire EX_OE; // Output Enable: enables writing data to output port

// Instantiate the pipeline register IR_DOF_TO_EX

IR_DOF_TO_EX DOF_EX (
   .clk(main_clk),
   .reset(rst),
   .RW(RW),
   .DA(DA),
   .MD(MD),
   .BS(BS),
   .PS(PS),
   .MW(MW),
   .FS(FS),
   .SH(SH),
   .OE(OE),
   .EX_RW(EX_RW),
   .EX_DA(EX_DA),
   .EX_MD(EX_MD),
   .EX_BS(EX_BS),
   .EX_PS(EX_PS),
   .EX_MW(EX_MW),
   .EX_FS(EX_FS),
   .EX_SH(EX_SH),
   .EX_OE(EX_OE)
);

assign OUT_MW = EX_MW; // Output the MW signal to the address memory

// bus_a and bus_b to hold results of MUXA and MUXB
// EX prefix is used to indicate that these wires are
// output from the pipeline register (DOF_EX)

wire [7:0] EX_bus_a;
wire [7:0] EX_bus_b;

// Instantiate the bus_a and bus_b pipeline registers from mux_bus module

mux_bus bus_a(
   .clk(main_clk),
   .reset(rst),
   .bus_in(busA),
   .bus_out(EX_bus_a)
);

mux_bus bus_b(
   .clk(main_clk),
   .reset(rst),
   .bus_in(busB),
   .bus_out(EX_bus_b)
);

assign data_out_DM = EX_bus_b;

// EX Stage -----------------------------------------------------------

// Data Hazard Stall (DHS)
// Wires
// wire DHS declared previously
// wire DHS_neg declared previously

// Instantiate the data hazard stall logic

data_hazard_stall dhs(
   .DOF_EX_RW(EX_RW),
   .DOF_EX_DA(EX_DA),
   .AA(AA),
   .BA(BA),
   .MA(MA),
   .MB(MB),
   .DHS(DHS)
);

// ALU
// Wires

wire [7:0] ALU_result; // Result of ALU operation
wire CF; // Carry flag from ALU

wire VF; // Overflow flag from ALU
wire NF; // Negative flag from ALU
wire DF; // Data Branch Flag from ALU

alu ALU (
   .A(EX_bus_a),
   .B(EX_bus_b),
   .input_port_data(data_input),
   .input_port_kb(KB_input),
   .function_select(EX_FS),
   .shift(EX_SH),
   .F(ALU_result),
   .C(CF),
   .Z(ZF),
   .V(VF),
   .N(NF)
);

// Logic for D Flag
assign DF = NF ^ VF; 

// Data Memory Assign
// Wires
// Wires for data memory declared previously
assign address_DM = EX_bus_a;

// EX/WB Pipeline Registers

// Wires
wire WB_DF;
wire [7:0] WB_ALU_result;
// Instantiate D_BIT Register
D_BIT d_bit_reg (
   .clk(main_clk),
   .reset(rst),
   .data_in(DF),
   .data_out(WB_DF)
);

F_RESULT f_result_reg (
   .clk(main_clk),
   .reset(rst),
   .data_in(ALU_result),
   .data_out(WB_ALU_result)
);

// Wires
wire [7:0] WB_data_DM; 

data_mem_reg dmem_reg(
   .clk(main_clk),
   .reset(rst),
   .data_in(data_in_DM),
   .data_out(WB_data_DM)
);

// Assigning RAA
assign RAA = EX_bus_a;

// OUTPUT_LSB and OUTPUT_MSB

// Wires
wire [7:0] O_LSB;
wire [7:0] O_MSB;

// Assign the wires to the register outputs
assign O_LSB = EX_bus_a;
assign O_MSB = EX_bus_b;

// Instantiate the output lsb and msb pipeline registers
OUT_LSB out_lsb (
   .clk(main_clk),
   .reset(rst),
   .load_enable(EX_OE),
   .data_in(O_LSB),
   .data_out(OUTPUT_LSB)
);

OUT_MSB out_msb (
   .clk(main_clk),
   .reset(rst),
   .load_enable(EX_OE),
   .data_in(O_MSB),
   .data_out(OUTPUT_MSB)
);

// IR_EX_TO_WB Pipeline Register that carries the data from EX to WB
// Wires


wire [1:0] WB_MD;


IR_EX_TO_WB EX_WB (
   .clk(main_clk),
   .reset(rst),
   .RW(EX_RW),
   .DA(EX_DA),
   .MD(EX_MD),
   .WB_RW(WB_RW),
   .WB_DA(WB_DA),
   .WB_MD(WB_MD)
);


// Branch Adder 


// Instantiate the branch adder
branch_adder br_adder (
   .A(PC_prev2),
   .B(EX_bus_b),
   .BrA(BrA)
);

// WB Stage -----------------------------------------------------------

// muxD to select what gets written into the Reg File
// Wires

wire [7:0] DF_Ext;
assign DF_Ext = {{7{1'b0}}, {WB_DF}}; // Zero pads the D-Bit

muxD muxd(
   .data_0(WB_ALU_result),
   .data_1(WB_data_DM),
   .data_2(DF_Ext),
   .sel(WB_MD),
   .data_out(bus_D)
);


endmodule

