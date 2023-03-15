module instruction_test_tb();

bit clk, reset;
wire done;
logic error[11];

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
/*
After running the instructions in dummy_basic
---------------------------------------------
     dut.dm1.core[3] =  8'b11110000 ;
     dut.rf1.core[3]  = 8'b11110000 ;
     dut.dm1.core[2] = 8'b00000001;
     dut.rf1.core[1] = 8'b00000011;
     dut.rf1.core[4] = 8'b00000001;
     dut.dm1.core[1] = 8'b00000010 ;
     dut.dm1.core[4] = 8'b00000000;
     dut.dm1.core[5] = 8'b10101010;
     dut.dm1.core[8] = 8'b00000000;
     dut.dm1.core[8] = 8'b01010101;
     dut.dm1.core[10] = 8'b00000001 ;



*/
  #10 reset = 1;
  #10 reset = 0;
  #10 wait(done);
  #2
  
  #10 
  error[1] = 8'b11110000 == dut.dm1.core[3];
  error[2] = 8'b11110000 == dut.rf1.core[3];
  error[3] = 8'b00000001 == dut.dm1.core[2];
  error[4] = 8'b00000011 ==  dut.rf1.core[1];
  error[5] = 8'b00000001 == dut.rf1.core[4];
  error[6] = 8'b00000010 == dut.dm1.core[1];
  error[7] = 8'b00000000 == dut.dm1.core[4];
  error[8] = 8'b10101010 == dut.dm1.core[5];
  error[9] = 8'b00000000 == dut.dm1.core[8];
  error[10] = 8'b01010101 == dut.dm1.core[9];
  //error[11] = 8'b00000001 == dut.dm1.core[10];
  //error[12] = 8'b00000000 == dut.dm1.core[11];
  //error[13] = 8'b00000000 == dut.dm1.core[12];

  $display("checking if lb and sb worked");
  $display(error[1]);
  $display("checking if addi works");
  $display(error[3]);
  $display("checking if movr works");
  //$display(dut.rf1.core[3]);
  $display(error[2]);
  $display("checking if sll and slr  work");
  $display(error[4]);
 // $display("Answer : %b compared to expected : %b",dut.rf1.core[1],8'b00000011);
  $display("checking if movi works");
  $display(error[5]);
  $display("checking if add/sub work");
  $display(error[6]);
  $display("checking if and works");
  $display(error[7]);
  $display("checking if or works");
  $display(error[8]);
  $display("checking if xor works");
  $display(error[9]);
  $display("checking if nor works");
  $display(error[10]);
  /*$display("checking if eq works");
  $display(error[11]);
  $display("checking if lt works");
  $display(error[12]);
  $display("checking if rxor works");
  $display(error[13]);*/
  $display("This is the first instruction ");
  $display(dut.ir1.core[0]);
  $display("This is the second instruction ");
  $display(dut.ir1.core[1]);
  $display("This is in data mem rn");
  $display(dut.dm1.core[0]);
  $stop;
end    

endmodule