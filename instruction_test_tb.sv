module instruction_test_tb();

bit clk, reset;
wire done;
logic error[8];

top_level dut(
  .clk,
  .reset,
  .done);


always begin
  #5 clk = 1;
  #5 clk = 0;
end

initial begin
  //reset = 1;
  dut.dm1.core[0] = 8'b11110000;
  dut.dm1.core[1] = 8'b00000001;
  dut.dm1.core[6] = 8'b10101010;
  dut.dm1.core[7] = 8'b01010101;
 // dut.dm1.core[1] = 8'b11001100;
  //dut.dm1.core[2] =	8'b11000011;
  //dut.dm1.core[3] = 8'b01010101;
  //dut.dm1.core[4] = 8'b00000000;

  //dut.dm1.core[7] = 8'b11110000;
  //#10 reset = 0;
  //#10 reset = 0;
  #10 reset = 1;
  #10 reset = 0;
  #10 wait(done);
  #2
  /*#10 error[0] = (8'b11110000 ^ 8'b11001100) != dut.dm1.core[2];
  #10 error[1] = (8'b11000011 & 8'b01010101) != dut.dm1.core[5];
  #10 error[2] = (^8'b00000000) != dut.dm1.core[7];
  #10 $display("checking and xor and rxor operations");*/
  #10 error[0] = 8'b11110000 == dut.rf1.core[6];
  error[1] = 8'b11110000 == dut.dm1.core[3];
  error[2] = 8'b11110000 == dut.rf1.core[3];
  error[3] = 8'b00000001 == dut.dm1.core[2];
  error[4] = 8'b00000011 ==  dut.rf1.core[1];
  error[5] = 8'b00000001 == dut.rf1.core[4];
  error[6] = 8'b00000010 == dut.dm1.core[1];
  error[7] = 8'b01010101 == dut.dm1.core[4];
  $display("checking if reg file stores the correct item");
  $display(error[0]);
  $display("checking if the lb workd");
  $display(error[1]);
  $display("checking if addi works");
  $display(error[3]);
  $display("checking if movr works");
  $display(error[2]);
  $display("checking if sll and slr  work");
  $display(error[4]);
 // $display("Answer : %b compared to expected : %b",dut.rf1.core[1],8'b00000011);
  $display("checking if movi works");
  $display(error[5]);
  $display("checking if add/sub work");
  $display(error[6]);
  $display("checking if logical operations work");
  $display(error[6]);
  $display("This is the first instruction ");
  $display(dut.ir1.core[0]);
  $display("This is the second instruction ");
  $display(dut.ir1.core[1]);
  $display("This is in data mem rn");
  $display(dut.dm1.core[0]);
  $stop;
end    

endmodule