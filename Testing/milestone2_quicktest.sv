// sample top level design
module top_level(
  input        clk, reset,  
  output logic done);

  logic DM_write;
  logic[7:0]  DM_dat_in, DM_addr, DM_dat_out, reg_file[4];


  dat_mem dm1(.dat_in(DM_dat_in)  ,  // from reg_file
             .clk           ,
			 .wr_en  (DM_write), // stores
			 .addr   (DM_addr),
             .dat_out(DM_dat_out));

  initial begin
    done = 0;
	DM_write = 0;
	wait(!reset);
	@(posedge clk) DM_addr = 0;
	@(posedge clk) reg_file[0] <= DM_dat_out;
	@(posedge clk) DM_addr = 1;
	@(posedge clk) reg_file[1] <= DM_dat_out;
	@(posedge clk);
	DM_write = 1; 
	DM_addr = 2;
	DM_dat_in = reg_file[0]^reg_file[1];
	@(posedge clk) DM_write = 0;
	@(posedge clk) DM_addr = 3;
	@(posedge clk) reg_file[2] <= DM_dat_out;
	@(posedge clk) DM_addr = 4;
	@(posedge clk) reg_file[3] <= DM_dat_out;
	@(posedge clk);
	DM_write = 1;
	DM_addr = 5;
	DM_dat_in = reg_file[2]&reg_file[3];
    @(posedge clk) DM_write = 0;
	@(posedge clk) done = 1;
  end

 
endmodule