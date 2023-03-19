movi $1,#0;
LOAD_MESSAGE:
addi $1, #1 ;
movi $5, #4 ;
eq $1, $1 ;
bt @LOAD_MESSAGE;
