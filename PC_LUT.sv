// Program Counter Lookup Table
// PC Lookup table to facilitate jumps/branches
module PC_LUT #(parameter D=12) (
	input       [  3:0]	addr,			// LUT Immediate (4-bit)
	output logic[D-1:0]	target		// Branch target address
);


// LUT
always_comb case (addr)
	
	'b0000 : target = 1;							// PC = 1 (LOAD_MESSAGE)
	default: target = 0;							// PC reset

endcase


endmodule
