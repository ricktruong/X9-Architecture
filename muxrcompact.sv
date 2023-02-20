//-----------------------------------------------------
// Design Name : mux_using_assign
// File Name   : mux_using_assign.v
// Function    : 2:1 Mux using Assign
// Coder       : Deepak Kumar Tala
//-----------------------------------------------------
module  mux_using_assign_rs #(parameter N =2)(
input[N:0] 	ibits,	rbits,
input		 sel,
output[N:0]	mux_out
			 // Mux first input
			 // Mux Second input

 // Select input      // Mux output
);
//-----------Input Ports---------------
//------------Internal Variables--------
//-------------Code Start-----------------
assign mux_out = (sel) ? ibits : rbits;

endmodule //End Of Module mux
