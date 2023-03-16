// Register File
// Default register address pointer width = 4, for 16 registers
module reg_file #(parameter pw=3)(
	input					clk,isaddi,ismovr, //alusrcdiv,
	input[1:0]  		addi_im,
	input[pw-1:0]		rd_addrA,			// Read register 1
							rd_addrB,			// Read register 2
							wr_addr,				// Write register pointer
	input					wr_en,				// Write register enable
	input[7:0]			dat_in,				// Write data
	output logic[7:0]	datA_out,			// Read data 1 output
							datB_out				// Read data 2 output
);

logic[7:0] core[2**pw];
logic[7:0] helper;	
// Output Read data 1 & Read data 2

assign datA_out = core[rd_addrA];
always@(dat_in) begin
	$display("dat_in is %d and wr-en is %b", dat_in, wr_en);

end
always @(*) begin
if(isaddi) begin
	//if(alusrcdiv) begin 
	case(addi_im)
	'b00	 : helper = 'b00000000;
	'b01	 : helper = 'b00000001;
	'b11	 : helper = 'b10000001;
	'b10	 : helper = 'b10000000;
	endcase
	//end
end
else begin
	helper = core[rd_addrB];
end
end
assign datB_out = helper;//core[rd_addrB];
 always @(datA_out or datB_out) begin
 	$display("data in rs %d",datA_out);
	$display("data that would be in rt %d", datB_out);
 end
// Write register logic
always_ff @(posedge clk)

	if (wr_en) begin
		
		/*if(ismovr) begin
			$display("we are writing %d into register number %d : ", helper, wr_addr);
			core[wr_addr] <= helper;
		end
		else begin*/
			$display("we are writing %d into register number %d : ", dat_in, wr_addr);
			core[wr_addr] <= dat_in;			// Write register with dat_in
			
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