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

// always_comb begin 
// 	$display("value found in rs : %d", datA_out);
// 	$display("value found in rt: %d", datB_out);	
// end

// Write register logic
always_ff @(posedge clk) begin
	
	$display(" --- REGISTER FILE VALUES --- ");
	$display("$0 : %d, %b", core[0], core[0]);
	$display("$1 : %d, %b", core[1], core[1]);
	$display("$2 : %d, %b", core[2], core[2]);
	$display("$3 : %d, %b", core[3], core[3]);
	$display("$4 : %d, %b", core[4], core[4]);
	$display("$5 : %d, %b", core[5], core[5]);
	$display("$6 : %d, %b", core[6], core[6]);
	$display("$7 : %d, %b", core[7], core[7]);
	$display(" ---------------------------- ");

	if (wr_en) begin
		core[wr_addr] <= dat_in;			// Write register with dat_in
		$display("We wrote %d into register %d", dat_in, wr_addr);
	end

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