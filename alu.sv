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

always @(alu_cmd) begin
	$display("The ALUOp is %b and the operands are %d and %d",alu_cmd,inA,inB);
end

// ALU Operations
always_comb begin 
	rslt = 'b0;            
	sc_o = 'b0;    
	one = &rslt;
	pari = ^rslt;
	
	case (alu_cmd)
	
		4'b0000: // add
			rslt = inA + inB;
		4'b0001: // sub
			rslt = inA - inB;
		4'b0010: // addi
			rslt = inA + inB;
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
		4'b0111: // nor
			rslt = !(inA | inB);
		4'b1000: // xor
			rslt = inA ^ inB;
		4'b1001: // and
			rslt = inA & inB;
		4'b1010: // or
			rslt = inA | inB;
		4'b1011: // sll
			rslt = inA << inB;
		4'b1100: // slr
			rslt = inB >>inB;
		4'b1101: // eq
			rslt = (inA == inB);
		4'b1110: // lt
			rslt = (inA < inB);
		4'b1111: // rxor
			rslt = ^inB;

	endcase
	
end

 
endmodule