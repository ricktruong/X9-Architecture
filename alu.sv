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
logic[7:0] helper;

// ALU Operations
always_comb begin 
	rslt = 'b0;            
	sc_o = 'b0;    
	one = &rslt;
	pari = ^rslt;
	
	case (alu_cmd)
	
		4'b0000: begin // add 
						$display("add instruction");
						rslt = inA + inB;
					end
		4'b0001: begin // sub
						$display("sub instruction");
						rslt = inA - inB;
					end
		4'b0010: begin  // addi
						$display("addi instruction");
						if(inB[7] == 'b1) begin
							if(inB[0] == 'b1) begin
							helper =  inB << 1;
							helper = helper >> 1;
							rslt = inA - helper;		
						end
						else begin
							rslt = inA -2;
						end
						end
						else begin
							rslt = inA + inB;
						end
					end
		4'b0011: begin // lb
						rslt = inA;
						$display("lb instruction which loaded data %d", rslt);
					end
		4'b0100: begin // sb
						rslt = inA;
						$display("sb instruction which stored data %d" ,rslt);
					end 
		4'b0101: begin // bt  <-- movr
			rslt = inB;
			$display("moving %b into a reg",inB);
		end
		4'b0110: begin // bne <-- movi
						
						rslt = rslt;
						$display("movi which moved the immediate %d", rslt);
					end
		4'b0111: begin // nor 
			rslt = ~(inA | inB);
			$display("we are norring %b with %b to get %b", inA, inB, rslt);
		end
		4'b1000: begin // xor
			rslt = inA ^ inB;
			$display("we are xorring %b with %b to get %b", inA, inB, rslt);
		end
		4'b1001: begin // and
			rslt = inA & inB;
			$display("we are anding %b with %b to get %b", inA, inB, rslt);
		end
		4'b1010: begin // or
			rslt = inA | inB;
			$display("we are orring %b with %b to get %b", inA, inB, rslt);
		end
		4'b1011:  begin// sll
					rslt = inA << inB;
					$display("We are shifting %b left by %d bits to get %b",inA, inB,rslt);

				end
		4'b1100: begin // slr 
					rslt = inA >> inB;
					$display("We are shifting %b  right by %d bits to get %b",inA, inB, rslt);

		end
		4'b1101:begin // eq
			rslt = (inA == inB);
			$display("checking if %b is equal to %b",inA, inB);
		end
		4'b1110: begin // lt
			rslt = (inA < inB);
			$display("checking if %b is less than %b", inA, inB);
		end
		4'b1111: begin// rxor
			rslt = ^inB;
			$display("rxorring %b to get %b",inB,rslt);
		end
	endcase
	
end

 
endmodule