// Register File
// Default register address pointer width = 4, for 16 registers
module reg_file #(parameter pw=3)(
	input					clk,
	input[pw-1:0]		rd_addrA,			// Read register 1
							rd_addrB,			// Read register 2
							wr_addr,				// Write register pointer
	input					wr_en,				// Write register enable
	input[7:0]			dat_in,				// Write data
	output logic[7:0]	datA_out,			// Read data 1 output
							datB_out				// Read data 2 output
);
always @(dat_in) begin
	$display("current reg_file input is %d and wr_en is %b",dat_in,wr_en);
end

logic[7:0] core[2**pw];						// Register core/space

// Output Read data 1 & Read data 2
assign datA_out = core[rd_addrA];
assign datB_out = core[rd_addrB];
always_comb begin 
	$display("value found in rs : %d", datA_out);
	$display("value found in rt: %d", datB_out);
	
end
// Write register logic
always_ff @(posedge clk)
	if (wr_en) begin
		core[wr_addr] <= dat_in;			// Write register with dat_in
		$display("We wrote %d into register %d", dat_in, wr_addr);
	end
	
endmodule

/*
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
	  xxxx_xxxx
*/