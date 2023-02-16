// Control Decoder
module Control #(parameter opwidth = 3, mcodebits = 4) (
  input [mcodebits-1:0]			instr,			// Instruction Opcode
  output logic						RegDst,			// Register Destination
										Branch,			// Branch
										MemtoReg,		// Memory to Register
										MemWrite,		// Memory Write
										ALUSrc,			// ALU Source
										RegWrite,		// Register Write
  output logic[opwidth-1:0]	ALUOp				// ALU Operation
);


// Control Decoder logic
always_comb begin
	
	// Defaults
	RegDst 	=	'b0;			// 1: not in place  just leave 0
	Branch	=  'b0;			// 1: branch (jump)
	MemWrite	=	'b0;			// 1: store to memory
	ALUSrc	=	'b0;			// 1: immediate  0: second reg file output
	RegWrite	=	'b1;			// 0: for store or no op  1: most other operations 
	MemtoReg	=	'b0;			// 1: load -- route memory instead of ALU to reg_file data in
	ALUOp		=  'b111;		// y = a+0;
	
	// sample values only -- use what you need
	case (instr)    // override defaults with exceptions
	  'b0000		:  begin					// store operation
							MemWrite = 'b1;      // write to data mem
							RegWrite = 'b0;      // typically don't also load reg_file
						end
	  'b00001	:  ALUOp      = 'b000;  // add:  y = a+b
	  'b00010	:  begin				  // load
							MemtoReg = 'b1;    // 
						end
	// ...
	endcase

end


endmodule