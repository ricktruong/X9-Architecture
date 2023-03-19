// sample top level design
module top_level(
  input        clk, reset, //req, 
  output logic done);

// Bit width specification variables - Program Counter (Instruction Memory size), ALU Commands (ALU Operation Set size)
parameter		D = 12,							// Program Counter width
					A = 4;							// ALU Command bit width

// Program Counter input wires
wire[D-1:0]		prog_ctr,						// Program Counter
					target;							// Target Instruction to jump/branch to
wire  			relj,								// Relative Jump enable
					absj;								// Absolute Jump enable
					
// Register File input wires
wire[8:0]   	mach_code;          			// Instruction to execute (9-bit)
wire[2:0] 		rd_addrA, rd_addrB,			// Read address 1, Read address 2
					rs_addrA, rt_addrB,			// R-Type
					id_addrA,id_addrB,			// I-Type
					wr_reg;							// Write register
wire[7:0]		regfile_dat,					// Write data
					immed;							// Immediate for movi to get written into Write data in Register File
wire[3:0] 		helper = 4'b0000;

// Control Signals
wire[1:0]		InstType;						// Instruction Type Control Signal
wire  			BranchInst,						// Branch Instruction Control Signal
					MemRead,							// Read Memory Control Signal
					MemtoReg;						// Memory to Register Control Signal
wire[3:0] 		ALUOp;							// ALU Operation
wire				MemWrite,						// Memory Write Control Signal
					ALUSrc,							// ALU Source Control Signal
					RegWrite;						// Register Write Control Signal

//	ALU input and output wires
wire[7:0]   	datA, datB,						// Read data 1, Read data 2
					alumux,
					rslt;								// ALU result
wire[5:0] 		helperB = 6'b000000;			// Bit-extension helper for addi immediate (WE WANT SIGN-EXTEND)

// Top Level registers for ALU bit flags
logic 			sc_in,							// Lagging Shift/Carry In/Out register
					pariQ,              	  		// Lagging Parity register
					oneQ;                   	// Lagging One regsiter
wire				pari,								// Current Parity wire
					one,								// Current One wire
					sc_o,								// Current Shift/Carry Out wire
					sc_clr,							// Shift/Carry In/Out clear signal
					sc_en;							// Shift/Carry In/Out enable signal
					
// Data Memory input and output wires
wire[7:0]		memdat,							// Data Memory output
					muxfin;							// Final MemToReg mux output value


// MODULE INSTANTIATIONS

// Program Counter
PC #(.D(D)) 					  // D sets Program Counter width
	pc1 (
		.reset										,
		.clk											,
		.reljump_en (relj)						,
		.absjump_en (absj)						,
		.target										,
		.prog_ctr
	);

// Program Counter Lookup Table
PC_LUT #(.D(D))				// D - Program Counter width
	pl1 (
		.addr		(mach_code[3:0])	,		// Branch LUT Immediate
		.target									// Branch target address
	);

// Instruction ROM (Read-Only Memory)
instr_ROM
	ir1(
		.prog_ctr,
		.mach_code
	);

always @(mach_code) begin
	$display("The mach_code for this instruction is %b", mach_code);
	$display("potential rs number for r-type:%d",rs_addrA);
	$display("potential rt number for r-type:%d",rt_addrB);
	$display("potential rs number for i-type:%d", id_addrA);
	$display("potential rt number for i-type:%d", id_addrB);
	$display("potential immediate value if the instruction is movi:%d",immed);
	$display("state of oneQ on instruction load %d",oneQ);

end

// Control Decoder
Control
	ctl1(
		.instr		(mach_code[8:4]),
		.InstType  	, 
		.BranchInst , 
		.MemRead		,
		.MemWrite	,
		.ALUSrc		, 
		.RegWrite	,     
		.MemtoReg	,
		.ALUOp		
	);

always @(InstType) begin
	$display("Insttype is %b with LSB being Insttype[0]",InstType);

end

// Branching logic
assign absj = BranchInst && oneQ;					// Branch Operator output

// Instruction decoding prior to Register File
assign rs_addrA = {1'b0,mach_code[3:2]};
assign id_addrA = mach_code[6:4];
assign rt_addrB = {1'b1,mach_code[1:0]};
assign id_addrB = mach_code[3:1];
assign immed = {helper, mach_code[3:0]};
assign immedB = {helperB, mach_code[1:0]};		// ***MUST FIGURE OUT HOW TO MAKE SIGN EXTEND MACH_CODE[1:0] FOR ADDI OF NEGATIVE NUMBERS

// Instruction decoding muxes
variable_mux #(.N(2)) rsmux (.ibits (id_addrA),.rbits (rs_addrA) ,.sel (InstType[1]),.mux_out (rd_addrA));
variable_mux #(.N(2)) rdmux  (.ibits (id_addrB),.rbits (rt_addrB) ,.sel (InstType[1]),.mux_out (rd_addrB));
variable_mux #(.N(7)) regdatamux (.ibits (immed), .rbits (muxfin) ,.sel (InstType[0]),.mux_out (regfile_dat));
assign wr_reg = (MemtoReg == 'b1) ? rd_addrB : rd_addrA;		// LB/SB Mux

always @(regfile_dat) begin
	$display("The number of register rs is %d",rd_addrA);
	$display("The number of register rt is %d", rd_addrB);
	$display("The value going into the register to be potentially written is %d",regfile_dat);
end

// Register File
reg_file #(.pw(3))						// Register Pointer width - 3 for 8 registers
	rf1(
		.clk,
		.rd_addrA	(rd_addrA)		,
		.rd_addrB	(rd_addrB)		,
		.wr_addr 	(wr_reg)			,
		.wr_en   	(RegWrite)		,
		.dat_in		(regfile_dat)	,
		.datA_out	(datA)			,
		.datB_out	(datB)
	); 

// ALU Mux logic
assign alumux = ALUSrc ? datB : immedB;

// ALU
alu
	alu1(
		.alu_cmd	(ALUOp)	,
		.inA    	(datA)	,
		.inB    	(alumux)	,
		.sc_i   	(sc_in)	,
		.rslt       		,
		.sc_o   	(sc_o)	,
		.pari					,
		.one
	);
always_comb begin
	$display("value of one changed to %b",one);
end
// Data Memory
dat_mem
	dm1(
		.dat_in	(datB)		,		// Read data 2 from reg_file
		.clk						,
		.wr_en	(MemWrite)	,		// Memory Write enable
		.addr		(rslt)		,		// Input memory address
		.dat_out	(memdat)				// Output memory data
	);

// Memory to Register mux
variable_mux #(.N(7)) memtoregmux (.ibits (memdat),.rbits (rslt), .sel (MemtoReg), .mux_out (muxfin));


// Top Level registers for ALU bit flags update logic
always_ff @(posedge clk) begin
	pariQ <= pari;
	oneQ <= one;
	if (sc_clr)
		sc_in <= 'b0;
	else if (sc_en)
		sc_in <= sc_o;
end

// TERMINATE ALL TESTS WHEN DONE
assign done = prog_ctr == 50;
 
endmodule
