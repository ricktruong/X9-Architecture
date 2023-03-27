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

// ALU Operations
always_comb begin 
	rslt = 'b0;            
	sc_o = 'b0;    
	one = 'bx;
	pari = ^rslt;
	
	case (alu_cmd)
	
		4'b0000: begin // add
			rslt = inA + inB;
		end
		4'b0001: begin // sub
			rslt = inA - inB;
		end
		4'b0010: begin // addi
			if (inB == 2) begin
				rslt = inA - 2;
			end
			else if (inB == 3) begin
				rslt = inA - 1;
			end
			else begin
				rslt = inA + inB;
			end
		end
		4'b0011: begin // lb
			rslt = inA;
		end
		4'b0100: begin // sb
			rslt = inA; 
		end
		4'b0101: // movr
			rslt = inB;
		4'b0110: begin // movi
			rslt = rslt;
		end
		4'b0111:begin // nor
			rslt = ~( inA | inB);
		end
		4'b1000: begin // xor
			rslt = inA ^ inB;
		end
		4'b1001: // and
			rslt = inA & inB;
		4'b1010: // or
			rslt = inA | inB;
		4'b1011: begin // sll
			rslt = inA << inB;
		end
		4'b1100: begin // slr
			rslt = inA >> inB;
		end
		4'b1101: begin // eq
			rslt = (inA == inB);
			one = rslt[0];
		end
		4'b1110: begin // lt
			rslt = (inA < inB);
			one = rslt[0];
		end
		4'b1111:begin // rxor
			rslt = ^inB;
		end
	endcase
	
end

 
endmodule