// Arithmetic Logic Unit (ALU)
module alu(
	input[2:0]			alu_cmd,			// ALU Operation
	input[7:0]			inA,				// Read data 1
							inB,				// Reat data 2
	input					sc_i,				// Shift/Carry In bit
	output logic[7:0]	rslt,				// ALU result
	output logic		sc_o,				// Shift/Carry Out bit
							pari,				// reduction XOR (output)
							zero				// NOR (output) - If current output is 0, zero flag will be 1. If current output is not 0, zero flag will be 0.
);


// ALU Operations
always_comb begin 
	rslt = 'b0;            
	sc_o = 'b0;    
	zero = !rslt;
	pari = ^rslt;
	
	case (alu_cmd)
		3'b000: // add 2 8-bit unsigned; automatically makes carry-out
			{sc_o,rslt} = inA + inB + sc_i;
		3'b001: // left_shift
			{sc_o,rslt} = {inA, sc_i};
			/*begin
			rslt[7:1] = ina[6:0];
			rslt[0]   = sc_i;
			sc_o      = ina[7];
			end*/
		3'b010: // right shift (alternative syntax -- works like left shift
			{rslt,sc_o} = {sc_i,inA};
		3'b011: // bitwise XOR
			rslt = inA ^ inB;
		3'b100: // bitwise AND (mask)
			rslt = inA & inB;
		3'b101: // left rotate
			rslt = {inA[6:0],inA[7]};
		3'b110: // subtract
			{sc_o,rslt} = inA - inB + sc_i;
		3'b111: // pass A
			rslt = inA;
	endcase
	
end

 
endmodule