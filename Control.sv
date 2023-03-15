// Control Decoder
module Control #(parameter opwidth = 4, mcodebits = 5) (
  input [mcodebits-1:0]			instr,			// Instruction Opcode
  output logic[1:0]				InstType,		// Register Destination
  output logic						BranchInst,		// BranchInst Instruction
										MemRead,
										MemtoReg,		// Memory to Register
										MemWrite,		// Memory Write
										ALUSrc,			// ALU Source
										RegWrite,
										isaddi,
										ismovr,
											// Register Write
  output logic[opwidth-1:0]	ALUOp				// ALU Operation
);


// Control Decoder logic
always_comb begin
	
	// Defaults
	InstType		=	'b00;			// 1: not in place  just leave 0
	BranchInst	=  'b0;			// 1: BranchInst (jump)
	MemRead 		= 	'b0;			// 0: read from memory
	MemWrite		=	'b0;			// 1: store to memory
	ALUSrc		=	'b1;			// 1: immediate  0: second reg file output
	RegWrite		=	'b1;			// 0: for store or no op  1: most other operations 
	MemtoReg		=	'b0;			// 1: load -- route memory instead of ALU to reg_file data in
	ALUOp			=  'b1111;	
	isaddi          = 'b0;
	ismovr 		    = 'b0;	// y = a+0;
	
	casez (instr)    // override defaults with exceptions

		'b00000	:	begin	// add
							$display(" add instruction(control)");
							ALUOp	= 'b0000;
							ALUSrc = 'b0;
						end
		'b00001	: 	begin	// sub
							$display("sub instruction(control)");
							ALUOp = 'b0001;
							ALUSrc = 'b0;
						end
		'b00010	:	begin	// addi
							$display("addi instruction(control)");
							ALUSrc = 'b0;
							ALUOp = 'b0010;
							isaddi = 'b1;
						end
		'b00011	:	begin	// lb
							$display("lb instruction(control)");
							InstType = 'b01;
							MemRead = 'b1;
							MemtoReg = 'b1;
							ALUOp = 'b0011;
							ALUSrc = 'b0;
							//ALUSrc = 'b0;
						end
		'b00100	:	begin	// sb
							$display("sb instruction(control)");
							InstType = 'b01;
							MemWrite = 'b1;
							RegWrite = 'b0;
							ALUOp = 'b0100;
							ALUSrc = 'b0;
						end
		'b00101	:	begin	// beq
							BranchInst = 'b1;
							RegWrite = 'b0;
						end
		'b00110	:	begin	//	bne
							BranchInst = 'b1;
							RegWrite = 'b0;
						end
		'b00111	:	begin	//nor
							$display("nor instruction(control)");
							ALUOp = 'b0111;
							ALUSrc ='b0;
						end
		'b01000	: begin	// xor
							$display("xor instruction(control)");
							ALUOp = 'b1000;
							ALUSrc ='b0;
						end
		'b01001	:	begin // and
							$display("and instruction(control)");
							ALUOp = 'b1001;
							ALUSrc ='b0;
						end
		'b01010	:	begin // or
							$display(" or instruction(control)");
							ALUOp = 'b1010;
							ALUSrc ='b0;
						end
		'b01011	:	begin // sll
							$display("sll instruction(control)");
							ALUOp = 'b1011;
							ALUSrc = 'b0;
						end
		'b01100	:	begin //	slr
							$display("slr isntruction(control)");
							ALUOp = 'b1100;
							ALUSrc = 'b0;
						end
		'b01101	:	begin	// eq
							$display("eq iinstruction(control)");
							ALUOp = 'b1101;
							RegWrite = 'b0;
							ALUSrc = 'b0;
							//iscond= 'b1;
						end
		'b01110	:	begin	// lt
							$display("lt instruction(control)");
							ALUOp = 'b1110;
							RegWrite = 'b0;
							ALUSrc = 'b0;
							//iscond = 'b1;
						end
		'b01111	:	begin	// rxor
							$display("rxor instructon(control)");
							ALUOp = 'b1111;
							ALUSrc = 'b0;
						end 
		'b10???	:	begin	// movr
							$display("movr instruction(control)");
							InstType = 'b10;
							ALUOp = 'b0101;
							ismovr = 'b1;
							//ALUSrc = 'b0;
						end
		'b11???	:	begin	// movi
							$display("movi instruction(control)");
							InstType = 'b11;
							ALUOp = 'b0110;
						end
						
	endcase

end


endmodule