// Instruction ROM (Read-Only Memory)
// 9 bits wide; as deep as you wish
module instr_ROM #(parameter D=12) (
	input       [D-1:0]	prog_ctr,			// prog_ctr	  address pointer
	output logic[ 8:0]	mach_code			// Instruction output
 );


logic[8:0] core[2**D];							// Instruction Memory core/space

initial begin
	//$display("hello about to read stuff");
	$readmemb("mach_code.txt", core);
end		// Load mach_code.txt program I, II, & III instructions into core

always_comb mach_code = core[prog_ctr];	// Output current instruction at program counter


endmodule


/*
sample mach_code.txt:

001111110		 // ADD r0 r1 r0
001100110
001111010
111011110
101111110
001101110
001000010
111011110
*/