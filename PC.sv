// Program Counter
// Supports both relative and absolute jumps
// Use either or both, as desired
module PC #(parameter D=12) (
	input						reset,				// Synchronous Reset
								clk,
								reljump_en,			// Relative Jump enable
								absjump_en,			// Absolute Jump enable
	input       [D-1:0]	target,				// Target Instruction to jump/branch to
	output logic[D-1:0]	prog_ctr				// Program Counter output - Points to instruction
);


// Timing logic for Program Counter
always_ff @(posedge clk)

	if (reset)
		prog_ctr <= '0;							// Reset Program Counter to 0
	
	else if (reljump_en)
		prog_ctr <= prog_ctr + target;		// Relative Jump to target
	
	else if (absjump_en)
		prog_ctr <= target;						// Absolute Jump to target
		
	else begin
		$display("current pc before inc is %d",prog_ctr);
		//$display(prog_ctr);
		prog_ctr <= prog_ctr + 'b1;	
	end		// Normal Program Counter incrementation


endmodule