// sample top level design
module top_level(
  input        clk, reset, //req, 
  output logic done);

// Bit width specification variables - Program Counter (Instruction Memory size), ALU Commands (ALU Operation Set size)
parameter	D = 12,							// Program Counter width
				A = 4;							// ALU Command bit width

// Program Counter input wires
wire[D-1:0]	prog_ctr,						// Program Counter
				target;							// Target Instruction to jump/branch to
wire  		relj,								// Relative Jump enable
				absj;								// Absolute Jump enable
wire[D-1-8:0]	target_helper = 4'b0000;	// Bit fill helper for target instruction

// Register File input wires
wire[8:0]   mach_code;          			// Instruction to execute (9-bit)
wire[2:0] 	rd_addrA, rd_addrB,
				rs_addrA, rt_addrB,// Read address 1, Read address 2
				id_addrA,id_addrB,
				wr_reg;
wire[1:0]	InstType;
wire[3:0] helper = 4'b0000;
wire[5:0] helperB = 6'b000000;

//	ALU input and output wires
wire[7:0]   datA, datB,						// Read data 1, Read data 2
				immed,							// Immediate (in MIPS but not ours)
				alumux,
				memdat,// Mux - Between Read data 2 and Immediate
				regfile_dat,
				muxfin,
				rslt;								// ALU result

// ALU bit flags
logic 		sc_in,							// Shift/Carry In/Out flag
				pariQ,              	  		// Registered Parity flag
				zeroQ;                    	// Registered Zero flag 

// ALU bit flags enable signals?
wire  		pari,
				zero,
				sc_clr,							// Shift/Carry In/Out clear signal
				sc_en;							// Shift/Carry In/Out enable signal

// Control Signals
wire  		RegWrite,						// Register Write Control Signal
				MemWrite,						// Memory Write Control Signal
				ALUSrc,
				MemRead,		              	// ALU Source Control Signal
				MemtoReg;
wire[3:0] 		ALUOp;						// ALU Operation

// MODULE INSTANTIATIONS

// Program Counter
PC #(.D(D)) 					  // D sets Program Counter width
	pc1 (
		.reset										,
		.clk											,
		.reljump_en (relj && zeroQ)						,
		.absjump_en (absj)						,
		.target		({target_helper, datb})	,
		.prog_ctr
	);

// Program Counter Lookup Table
PC_LUT #(.D(D))
	pl1 (
		.addr  (how_high),					// wtf is how_high???
		.target
	);   

// Instruction ROM (Read-Only Memory)
instr_ROM
	ir1(
		.prog_ctr,
		.mach_code
	);

// Control Decoder
Control
	ctl1(
		.instr		(mach_code[8:4]),
		.InstType  	, 
		.Branch  	(relj), 
		.MemRead	,
		.MemWrite	,
		.ALUSrc		, 
		.RegWrite	,     
		.MemtoReg	,
		.ALUOp		
	);

// Instruction decoding prior to Register File
assign rs_addrA = {1'b0,mach_code[3:2]};
assign id_addrA = mach_code[6:4];
assign rt_addrB = {1'b1,mach_code[1:0]};
assign id_addrB = mach_code[3:1];
assign immed = {helper, mach_code[3:0]};
assign immedB = {helperB, mach_code[1:0]};

variable_mux #(.N(2)) rsmux (.ibits (id_addrA),.rbits (rs_addrA) ,.sel (InstType[1]),.mux_out (rd_addrA));
variable_mux #(.N(2)) rdmux  (.ibits (id_addrB),.rbits (rt_addrB) ,.sel (InstType[1]),.mux_out (rd_addrB));
variable_mux #(.N(7)) regdatamux (.ibits (immed), .rbits (muxfin) ,.sel (InstType[0]),.mux_out (regfile_dat));
assign wr_reg = InstType == 'b01 ? rd_addrB : rd_addrA;

// Register File
reg_file #(.pw(3))						// Register Pointer width - 3 for 8 registers
	rf1(
		.clk,
		.rd_addrA	(rd_addrA),
		.rd_addrB	(rd_addrB),
		.wr_addr 	(wr_reg),
		.wr_en   	(RegWrite),
		.dat_in		(regfile_dat),
		.datA_out	(datA),
		.datB_out	(datB)
	); 

// ALU Mux logic
assign alumux = ALUSrc ? datB : immedB;

// ALU
alu
	alu1(
		.alu_cmd(ALUOp),
		.inA    (datA)	,
		.inB    (alumux)	,
		.sc_i   (sc)	,
		.rslt       	,
		.sc_o   (sc_o)	,
		.pari			,
		.zero
	);

// Data Memory
dat_mem
	dm1(
		.dat_in	(datB),  // from reg_file
		.clk		,
		.wr_en	(MemWrite), // stores
		.addr		(rslt),
		.dat_out	(memdat)
	);

variable_mux #(.N(7)) memtoregmux (.ibits (memdat),.rbits (rslt), .sel (MemtoReg), .mux_out (muxfin));

// ALU bit flags update logic
always_ff @(posedge clk) begin
	pariQ <= pari;
	zeroQ <= zero;
	if (sc_clr)
		sc_in <= 'b0;
	else if (sc_en)
		sc_in <= sc_o;
end

// TERMINATE ALL TESTS WHEN DONE
assign done = prog_ctr == 15;
 
endmodule
