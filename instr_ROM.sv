// Instruction ROM (Read-Only Memory)
// 9 bits wide; as deep as you wish
module instr_ROM #(parameter D=12) (
	input       [D-1:0]	prog_ctr,			// prog_ctr	  address pointer
	output logic[ 8:0]	mach_code			// Instruction output
 );


logic[8:0] core[2**D];							// Instruction Memory core/space

initial
	$readmemb("mach_code.txt", core);		// Load mach_code.txt program I, II, & III instructions into core

always_comb mach_code = core[prog_ctr];	// Output current instruction at program counter


endmodule
