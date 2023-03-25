// Arithmetic Logic Unit (ALU)
module alu (
	input[3:0]			alu_cmd,			// ALU Operation
	input[7:0]			inA,				// Read data 1
							inB,				// Reat data 2
	input					sc_i,				// Shift/Carry In bit
	output logic[7:0]	rslt,				// ALU result
	output logic		sc_o,				// Shift/Carry Out bit
							pari,				// reduction XOR (output)
							one				// Flag to indicate 1 (True) for branching
);

// always @(alu_cmd) begin
// 	$display("The ALUOp is %b and the operands are %d and %d",alu_cmd,inA,inB);
// end

// ALU Operations
always_comb begin 
	rslt = 'b0;            
	sc_o = 'b0;    
	one = 'bx;
	pari = ^rslt;
	
	case (alu_cmd)
	
		4'b0000: begin // add
			rslt = inA + inB;
			// $display("We are adding %d to %d to get %d", inA, inB,rslt);
		end
		4'b0001: begin // sub
			rslt = inA - inB;
			// $display("We are subtracting %d from %d to get %d",inB,inA,rslt);
		end
		4'b0010: begin // addi
			if (inB == 2)
				rslt = inA - 2;
			else if (inB == 3)
				rslt = inA - 1;
			else
				rslt = inA + inB;
		end
		4'b0011: begin // lb
			rslt = inA;
			$display("we are trying to load at Mem[%d]",rslt);
		end
		4'b0100: begin // sb
			rslt = inA; 
			$display("we are trying to store at Mem[%d]",rslt);
		end
		4'b0101: // bt  <-- movr
			rslt = inB;
		4'b0110: begin // bne <-- movi
			rslt = rslt;
			$display("we are trying to movi %d",rslt);
		end
		4'b0111:begin // nor
			rslt = ~( inA | inB);
			// $display("we are norring %b with %b to get %b",inA, inB,rslt);
		end
		4'b1000: // xor
			rslt = inA ^ inB;
		4'b1001: // and
			rslt = inA & inB;
		4'b1010: // or
			rslt = inA | inB;
		4'b1011: begin // sll
			rslt = inA << inB;
			// $display("%b is shifted left by %d bits to give %b",inA,inB,rslt);
		end
		4'b1100: begin // slr
			rslt = inA >> inB;
			// $display("%b is shifted right by %d bits to give %b",inB,inB,rslt);
		end
		4'b1101: begin // eq
			rslt = (inA == inB);
			one = rslt[0];
			// $display("checking if %b is equal to %b and correctly displayd as %b and one is rightly updated to %b", inA, inB,rslt,one);
		end
		4'b1110: begin // lt
			rslt = (inA < inB);
			one = rslt[0];
			// $display("checking if %d is less than %d and correctly display as %b,",inA,inB,rslt);
		end
		4'b1111:begin // rxor
			rslt = ^inB;
			// $display("we have reduce xor'd %b to get %b",inB,rslt);
		end
	endcase
	
end

 
endmodule