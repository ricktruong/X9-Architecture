
module  variable_mux #(parameter N =2)(
input[N:0] 	ibits,	rbits,
input		 sel,
output[N:0]	mux_out

);

assign mux_out = (sel) ? ibits : rbits;

endmodule 
