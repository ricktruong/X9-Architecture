// sample top level design
module top_level(
  input        clk, reset, //req, 
  output logic done);

// Bit width specification variables - Program Counter (Instruction Memory size), ALU Commands (ALU Operation Set size)
parameter		D = 12,							// Program Counter width
					A = 4;							// ALU Command bit width

// Program Counter input wires
//wire addi_en = 'b1;
wire[D-1:0]		prog_ctr,						// Program Counter
					target;							// Target Instruction to jump/branch to
wire  			relj,alusrcdiv,								// Relative Jump enable
					absj;								// Absolute Jump enable
logic 				isaddi,ismovr,iscond;
// Register File input wires
wire[8:0]   	mach_code; 
wire[1:0]       addi_addrB;       			// Instruction to execute (9-bit)
wire[2:0] 		rd_addrA, rd_addrB,rdrbits,		// Read address 1, Read address 2
					rs_addrA, rt_addrB,			// R-Type
					id_addrA,id_addrB,			// I-Type
					wr_reg;							// Write register
wire[3:0] 		helper = 4'b0000;
wire[5:0] 		helperB = 6'b000000;

//	ALU input and output wires
wire[7:0]   	datA, datB,						// Read data 1, Read data 2
					immed,							// Immediate (in MIPS but not ours)
					alumux,
					memdat,// Mux - Between Read data 2 and Immediate
					regfile_dat,
					muxfin,
					rslt;								// ALU result

// Control Signals
wire[1:0]		InstType;						// Instruction Type Control Signal
wire  			BranchInst,						// Branch Instruction Control Signal
					MemRead,							// Read Memory Control Signal
					MemtoReg;						// Memory to Register Control Signal
wire[3:0] 		ALUOp;							// ALU Operation
wire				MemWrite,						// Memory Write Control Signal
					ALUSrc,							// ALU Source Control Signal
					RegWrite;						// Register Write Control Signal

// Top Level registers for ALU bit flags
logic 			sc_in,							// Lagging Shift/Carry In/Out register
					pariQ,              	  		// Lagging Parity register
					oneQ;                   	// Lagging One regsiter
wire				pari,								// Current Parity wire
					one,								// Current One wire
					sc_o,								// Current Shift/Carry Out wire
					sc_clr,							// Shift/Carry In/Out clear signal
					sc_en;							// Shift/Carry In/Out enable signal
					

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
	$display("Mach code is %b",mach_code);
	$display("rs is %d", rs_addrA);
	$display("rt is %d", rt_addrB);
	$display("rs(i type) is %d", id_addrA);
	$display("rt(i type) is %d", id_addrB);
	$display("immed is %d", immed);
	$display("immedB is %d", immedB);

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
		.isaddi , 
		.ismovr,   
		.MemtoReg	,
		.ALUOp		
	);
	//assign alusrcdiv = (ALUOp[2] == 'b1) ? 'b0 : 'b1;
	always@(InstType) begin
		$display("The inst code bits are %b", InstType);
		$display("Instype[0] %b",InstType[0]);
		$display("Instype[1] %b",InstType[1]);
	end
	
// Branching logic
assign absj = BranchInst && oneQ;					// Branch Operator output
assign varA = mach_code[3:2];
assign varB = mach_code[1:0];
// Instruction decoding prior to Register File
assign rs_addrA = {1'b0, mach_code[3:2]}; //
assign id_addrA = mach_code[6:4];
assign rt_addrB = {1'b1, mach_code[1:0]};
assign id_addrB = mach_code[3:1];
assign addi_addrB = mach_code[1:0];
assign immed = {helper, mach_code[3:0]};
assign immedB = {helperB, mach_code[1:0]};
// always @(rs_addrA or rt_addrB) begin
	
// end
// always @(id_addrA or id_addrB) begin
	
// end
// always @(immed or immedB) begin
	
// end
// Instruction decoding muxes
variable_mux #(.N(2)) rsmux (.ibits (id_addrA),.rbits (rs_addrA) ,.sel (InstType[1]),.mux_out (rd_addrA));
//variable_mux #(.N(2)) rtmux(.ibits(rt_addrB),.rbits(addi_addrB) ,.sel(ALUSrc), .mux_out(rdrbits));
variable_mux #(.N(2)) rdmux  (.ibits (id_addrB),.rbits (rt_addrB) ,.sel (InstType[1]),.mux_out (rd_addrB));
variable_mux #(.N(7)) regdatamux (.ibits (immed), .rbits (muxfin) ,.sel (InstType[1]),.mux_out (regfile_dat));
always @(rd_addrA) begin
	$display("value being treated as rs is %d", rd_addrA);
end
always @(rd_addrB) begin
		$display("value being treated as rt is %d", rd_addrB);
end
/*always @(regfile_dat) begin
	$display("data taht could be written into the regfile is : %d", regfile_dat);
end*/
/*always @(rd_addrA or rd_addrB) begin
	$display("value being treated as rs is %d", rd_addrA);
	$display("value being treated as rt is %d", rd_addrB);
end*/
assign wr_reg = (InstType == 'b01) ? rd_addrB : rd_addrA;
//assign addi_en = ALUSrc ? 'b0 : 'b1;
// Register File
reg_file #(.pw(3))						// Register Pointer width - 3 for 8 registers
	rf1(
		.clk,
		.isaddi,
		.ismovr,
		//.alusrcdiv,
		.addi_im    (addi_addrB) ,
		.rd_addrA	(rd_addrA)		,
		.rd_addrB	(rd_addrB)		,
		.wr_addr 	(wr_reg)			,
		.wr_en   	(RegWrite)		,
		.dat_in		(regfile_dat)	,
		.datA_out	(datA)			,
		.datB_out	(datB)
	); 
	/*always @(datB) begin
		$display("The value stored in the %d register(rt) is %d", rd_addrB, datB);
	end*/

// ALU Mux logic
assign alumux = ALUSrc  ? immedB : datB;
always @(alumux) begin
	$display("This is going into alu : %d between the immedB %d and the datB %d", alumux, immedB, datB);
end

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
/*always @(muxfin) begin
	$display("This is going into reg : %d", muxfin);
end*/

// Top Level registers for ALU bit flags update logic
always_ff @(posedge clk) begin
	pariQ <= pari;
	oneQ <= one;
	if (sc_clr)
		sc_in <= 'b0;
	else if (sc_en)
		sc_in <= sc_o;
end
 initial begin
	wait(!reset);
 end

// TERMINATE ALL TESTS WHEN DONE
assign  done = prog_ctr == 9;

 
endmodule
