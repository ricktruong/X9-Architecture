module milestone2_simple_tb();

bit clk, reset;
wire done;
logic error[2];

top_level dut(
  .clk,
  .reset,
  .done);


always begin
  #5 clk = 1;
  #5 clk = 0;
end

initial begin
  dut.dm1.core[0] = 8'b00000000;
  dut.dm1.core[1] = 8'b00000010;
  #10 reset = 1;
  #10 reset = 0;
  #10 wait(done);
  #10 error[0] = 8'b00000010 + 8'b00000010;
  #10 error[1] = dut.dm1.core[2];
  #10 $display(error[0],,,error[1]);
  $stop;
end

endmodule