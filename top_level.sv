// sample top level design
module top_level(
  input        clk, reset, req, 
  output logic done);

// Bit width specification variables - Program Counter (Instruction Memory size), ALU Commands (ALU Operation Set size)
parameter	D = 12,							// Program Counter width
				A = 3;							// ALU Command bit width

// Program Counter input wires
wire[D-1:0]	prog_ctr,						// Program Counter
				target;							// Target Instruction to jump/branch to
wire  		relj,								// Relative Jump enable
				absj;								// Absolute Jump enable

// Register File input wires
wire[8:0]   mach_code;          			// Instruction to execute (9-bit)
wire[2:0] 	rd_addrA, rd_adrB;   		// Read address 1, Read address 2

//	ALU input and output wires
wire[7:0]   datA, datB,						// Read data 1, Read data 2
				immed,							// Immediate (in MIPS but not ours)
				muxB,								// Mux - Between Read data 2 and Immediate
				rslt;								// ALU result
wire[A-1:0] alu_cmd;							// ALU Operation

// ALU bit flags
logic 		sc_in,							// Shift/Carry In/Out flag
				pariQ,              	  		// Registered Parity flag
				zeroQ;                    	// Registered Zero flag 

// ALU bit flags enable signals?
wire  		pari,
				zero,
				sc_clr,							// Shift/Carry In/Out clear signal
				sc_en,							// Shift/Carry In/Out enable signal

// Control Signals
wire  		RegWrite;						// Register Write Control Signal
				MemWrite,						// Memory Write Control Signal
				ALUSrc;		              	// ALU Source Control Signal

// MODULE INSTANTIATIONS

// Program Counter
PC #(.D(D)) 					  // D sets Program Counter width
	pc1 (
		.reset					,
		.clk						,
		.reljump_en (relj)	,
		.absjump_en (absj)	,
		.target					,
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
		.instr		(),
		.RegDst  	(), 
		.Branch  	(relj), 
		.MemWrite	, 
		.ALUSrc		, 
		.RegWrite	,     
		.MemtoReg	(),
		.ALUOp		()
	);

// Instruction decoding prior to Register File
assign rd_addrA = mach_code[2:0];
assign rd_addrB = mach_code[5:3];
assign alu_cmd  = mach_code[8:6];

// Register File
reg_file #(.pw(3))						// Register Pointer width - 3 for 8 registers
	rf1(
		.clk,
		.rd_addrA	(rd_addrA),
		.rd_addrB	(rd_addrB),
		.wr_addr 	(rd_addrB),
		.wr_en   	(RegWrite),
		.dat_in		(regfile_dat),
		.datA_out	(datA),
		.datB_out	(datB)
	); 

// Mux B logic
assign muxB = ALUSrc? immed : datB;

// ALU
alu
	alu1(
		.alu_cmd(),
		.inA    (datA),
		.inB    (muxB),
		.sc_i   (sc),
		.rslt       ,
		.sc_o   (sc_o),
		.pari
	);

// Data Memory
dat_mem
	dm1(
		.dat_in	(datB),  // from reg_file
		.clk		,
		.wr_en	(MemWrite), // stores
		.addr		(datA),
		.dat_out	()
	);

// ALU bit flags update logic
always_ff @(posedge clk) begin
	pariQ <= pari;
	zeroQ <= zero;
	if(sc_clr)
		sc_in <= 'b0;
	else if(sc_en)
		sc_in <= sc_o;
end

// TERMINATE ALL TESTS WHEN DONE
assign done = prog_ctr == 128;
 
endmodule