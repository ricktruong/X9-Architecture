// Data Memory
// 8-bit wide, 256-word (byte) deep memory array
module dat_mem (
	input					clk,
	input[7:0]			dat_in,				// Write data
	input					wr_en,				// Write Memory enable
	input[7:0]			addr,					// Address pointer
	output logic[7:0]	dat_out				// Data Memory output
);

// always @(dat_in) begin
// 	$display("The value we are potentially trying to store at Mem[%d] is %d where wr_en = %d", addr, dat_in, wr_en);
// end


logic[7:0] core[256];						// Data Memory core/space

// Output Data output
assign dat_out = core[addr];

// Write Memory logic
always_ff @(posedge clk)
	if (wr_en)
		core[addr] <= dat_in;				// Write Memory Address with dat_in

endmodule