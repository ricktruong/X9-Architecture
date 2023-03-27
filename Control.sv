// Control Decoder
module Control #(parameter opwidth = 4, mcodebits = 5) (
  input [mcodebits-1:0]			instr,			// Instruction Opcode
  output logic[1:0]				InstType,		// Register Destination
  output logic						BranchInst,		// BranchInst Instruction
										MemRead,
										MemtoReg,		// Memory to Register
										MemWrite,		// Memory Write
										ALUSrc,			// ALU Source
										RegWrite,		// Register Write
  output logic[opwidth-1:0]	ALUOp				// ALU Operation
);


// Control Decoder logic
always_comb begin
	
	// Defaults
	InstType		=	'b00;			// 1: not in place  just leave 0
	BranchInst	=  'b0;			// 1: BranchInst (jump)
	MemRead 		= 	'b0;			// 0: read from memory
	MemWrite		=	'b0;			// 1: store to memory
	ALUSrc		=	'b1;			// 1: second reg file output  0: immediate 
	RegWrite		=	'b1;			// 0: for store or no op  1: most other operations 
	MemtoReg		=	'b0;			// 1: load -- route memory instead of ALU to reg_file data in
	ALUOp			=  'b1111;
	
	casez (instr)    // override defaults with exceptions

		'b00000	:	begin	// add
							ALUOp	= 'b0000;
						end
		'b00001	: 	begin	// sub
							ALUOp = 'b0001;
						end
		'b00010	:	begin	// addi
							ALUSrc = 'b0;
							ALUOp = 'b0010;
						end
		'b00011	:	begin	// lb
							MemRead = 'b1;
							MemtoReg = 'b1;
							ALUOp = 'b0011;
						end
		'b00100	:	begin	// sb
							MemWrite = 'b1;
							RegWrite = 'b0;
							ALUOp = 'b0100;
						end
		'b00101	:	begin	// bt
							BranchInst = 'b1;
							RegWrite = 'b0;
						end
		'b00110	:	begin	//	bne - DEPRECATED
							BranchInst = 'b1;
							RegWrite = 'b0;
						end
		'b00111	:	begin	// nor
							ALUOp = 'b0111;
						end
		'b01000	:	begin	// xor
							ALUOp = 'b1000;
						end
		'b01001	:	begin	// and
							ALUOp = 'b1001;
						end
		'b01010	:	begin	// or
							ALUOp = 'b1010;
						end
		'b01011	:	begin	// sll
							ALUOp = 'b1011;
						end
		'b01100	:	begin	// slr
							ALUOp = 'b1100;
						end
		'b01101	:	begin	// eq
							ALUOp = 'b1101;
							RegWrite = 'b0;
						end
		'b01110	:	begin	// lt
							ALUOp = 'b1110;
							RegWrite = 'b0;
						end
		'b01111	:	begin	// rxor
							ALUOp = 'b1111;
						end 
		'b10???	:	begin	// movr
							InstType = 'b10;
							ALUOp = 'b0101;
						end
		'b11???	:	begin	// movi
							InstType = 'b11;
							ALUOp = 'b0110;
						end
						
	endcase

end


endmodule