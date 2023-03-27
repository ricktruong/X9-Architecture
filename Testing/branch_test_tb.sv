module branch_test_tb();

bit clk, reset;
wire done;
//logic error[2];

top_level dut(
  .clk,
  .reset,
  .done);


always begin
  #5 clk = 1;
  #5 clk = 0;
end
initial begin

  #10 reset = 1;
  #10 reset = 0;
  #10 wait(done);
  $display("Value at the reg 1 at end of the loop : %d",dut.rf1.core[1]);
  $display("Value at the reg 5 at end of the loop : %d",dut.rf1.core[5]);
  $stop;
end

endmodule