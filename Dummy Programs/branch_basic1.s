movi $1,#0;
movi $5, #4 ;
LOAD_MESSAGE:
addi $1, #1 ;
lt $1, $5 ;
bt @LOAD_MESSAGE;
