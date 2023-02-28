movi   $5, #7
movi   $0, #2
sll    $5, $0
add    $5, $0

START:
lw     $6, $5    	  ;$6 = D11D10D9D8D7D6D5P8
movi   $0, #1
add    $0, $5
lw     $7, $0     	  ;$7 = D4D3D2P4D1P2P1P0
movr   $1, $6  	  ;$1 = D11D10D9D8D7D6D5P8
movi   $3, #1
and    $3, $1	  ;$3 = 0000000P8
rxor   $1, $1              ;$1 =  D11^D10^D9^D8^D7^D6^D5^P8
xor    $1, $3         ;$1= ^[D11:D5]
movr   $2, $7      ;$2 = D4D3D2P4D1P2P1P0
movi   $4, #5
add    $4, $4
add    $4, $4
add    $4, $4
addi   $4, #1
addi   $4, #1        ;$4 = 00010110 = 22
and    $4, $2        ;$4 = 000P40P2P10
rxor   $4, $4              ;$4 = P1^P2^P4
xor    $3, $4         ;$3 = P1^P2^P4 ^P8
movi   $0, #3
slr    $2, $0          ;$2 = 000D4D3D2P1D1
movi   $0, #7
add    $0, $0
add    $0, $0
add    $0, $0
addi   $0, #1       :$0 = 00011101 = 29     
and    $2, $0       ;$2 = 000D4D3D20D1
rxor   $2, $2          ;2 = D4^D3^D2^D1
xor    $1, $2       ;$1 = ^[D11:D1]
xor    $1, $3       ;$1 = ^[D11:D1] ^ P1^P2^P4 ^P8 = Q0
movi   $4, #1
and    $4, $7       ;$4 = 0000000P0
xor    $1, $4        ;$1 = Q0 ^P0 = S0
movi   $0, #0
eq     $1, $0
;bne    $1,ONEBITFAIL
movr   $1, $6 	  ;$1 = D11D10D9D8D7D6D5P8
movi   $2, #1
movr   $3, $2
and    $3, $1	  ;$3 = 0000000P8
slr    $1, $2	  ;$1 = 0D11D10D9D8D7D6D5
rxor   $1, $1		  ;$1 =  D11^D10^D9^D8^D7^D6^D5 = Q8
xor    $1, $3         ;$1 = Q8 ^P8
eq     $1, $0
;bne    $1,FAILTWOBIT
movr   $1, $6       ;$1 = D11D10D9D8D7D6D5P8
movi   $2, #4
slr    $1, $2	  ;$1 = 0000D11D10D9D8
rxor   $1, $1		  ;$1 =  D11^D10^D9^D8
movr   $3, $7       ;$3 = D4D3D2P4D1P2P1P0
movi   $2, #5
slr    $3, $2	  ;$3 = 00000D4D3D2
rxor   $3, $3	  ;$3 = D4^D3^D2
xor    $1, $3         ;$1 = D11^D10^D9^D8^D4^D3^D2 = Q4
movi   $2, #1
sll    $2, $2
sll    $2, $2
add    $2, $2        ;$2 = 16
and    $2, $7        ;$2 =000P40000
movi   $4, #4
slr    $2, $4          ;$2 =000000P4
xor    $1, $2        ;$1 = P4 ^Q4  = S4
eq     $1, $0
;bne    $1,FAILTWOBIT
movr   $1, $6 	  ;$1 = D11D10D9D8D7D6D5P8
movi   $3, #6
add    $3, $3     ;#3 = 00001100 = 12
and    $3, $1  	  ;$3 = 0000D7D600
rxor   $3, $3           #3 = D7 ^D6
movi   $4, #6
slr    $1, $4          ;$1 = 000000D11D10
rxor   $1, $1	             ;$1 = D10 ^D11
xor    $1, $3	  ;$1 = D10 ^D11^ D7 ^D6
movr   $2, $7 	  ;$2 = D4D3D2P4D1P2P1P0
movi   $0, #7
addi   $0, #1     ;$0 = 8 =00001000
and    $0, $2	  ;$0 = 0000D1000
slr    $2, $4	  ;$2 = 000000D4D3
rxor   $2, $2 	  ;$2 = D4^D3
xor    $2, $0	  ;$2 = D4^D3^D1
xor    $1, $2	  ;$1 = D10 ^D11^ D7 ^D6^D4^D3^D1
movr   $2, $7	  ;$2 = D4D3D2P4D1P2P1P0
movi   $4, #4 
and    $2, $4 	  ;$2 = 00000P200
movi   $4, #2
sll    $2, $4 	  ;$2 = 0000000P2
xor    $1, $2	  ;$1 = D10 ^D11^ D7 ^D6^D4^D3^D1^P2=S2
movi   $0, $0
eq     $1, $0
;bne    $1, FAILTWOBIT
movr   $1, $6	  ;$1 = D11D10D9D8D7D6D5P8
movi   $2, #5
add    $2, $2     ; $2 = 00001010 = 10 
and    $2, $1	  ;$2 = 0000D70D50
rxor   $2, $2		  ;$2 = D7 ^ D5
movi   $3, #5
slr    $1, $3 	  ;$1 = 00000D11D10D9
and    $1, $3	  ;$1 = 00000D110D9
rxor   $3, $3		  ;$3 = D11 ^ D9
xor    $3, $2	  ;$3 = D11 ^ D9 ^ D7 ^ D5
movr   $2, $7	  ;$2 = D4D3D2P4D1P2P1P0
movi   $1, #3
slr    $2, $1	  ;$2 = 000D4D3D2P4D1
movi   $0, #7
add    $0, $0
add    $0, $0     ;$0 = 00010101 = 21
and    $0, $2 	  ;$2 = 000D40D20D1
rxor   $0, $0		  ;$0 = D4^D2^D1
xor    $3, $0 	  ;$3 = D11 ^ D9 ^ D7 ^ D5 ^ D4^D2^D1
movi   $0, #2
and    $0, $7   	  ;$0 = 000000P10
movi   $4, #1
sll    $0, $4	  ;$0 = 0000000P1
xor    $3, $0	  ;$3 = D11 ^ D9 ^ D7 ^ D5 ^ D4^D2^D1 ^ P1
movi   $0, #0 
eq     $3, $0
;bne    $3, FAILTWOBIT



FAILTWOBIT:
movi   $1, #1
movi   $2, #7
sll    $1, $2
movr   $3, $5
movi   $4, #5
add    $4, $4
add    $4, $4
add    $4, $4
add    $4, $4
add    $4, $4     ;$4 = 000110110 = 30
sub    $3, $4
sb     $1, $3
addi   $5, #1
addi   $5, #1    
add    $4, $4
movr   $0, $4
addi   $0, #-1   ;$0 = 00111011 = 59
movr   $2, $5
lt     $2, $0
;bt    $2, START
;bne    $5, FINISH

FAILONEBIT:
movr   $1, $6 	  ;$1 = D11D10D9D8D7D6D5P8
movi   $2, #1
movr   $3, $2
and    $3, $1	  ;$3 = 0000000P8
slr    $1, $2	  ;$1 = 0D11D10D9D8D7D6D5
rxor   $1, $1		  ;$1 =  D11^D10^D9^D8^D7^D6^D5 = Q8
xor    $1, $3         ;$1 = Q8 ^P8 = S8
movi   $4, #3
slr    $1, $4 	   ;$1 = 0000S8000
movr   $2, $6	  ;$2 = D11D10D9D8D7D6D5P8
movi   $0, #4
slr    $2, $0 	  ;$2 = 0000D11D10D9D8
rxor   $2, $2	  ;$2 = D11^D10^D9^D8
movr   $3, $7       ;$3 = D4D3D2P4D1P2P1P0
movi   $0, #4  	
slr    $3, $0 	  ;$3 = 0000D4D3D2P4
movi   $4, #1
and    $4, $3	  ;$4 = 0000000P4
movi   $0, #1 	  ;$3 = 00000D4D3D2
slr    $3, $0 
rxor   $3, $3	  ;$3 = D4^D3^D2
xor	   $2, $3 	  ;$2 = Q4
xor	   $2, $4         ;$2 = S4
addi   $0, #1
slr    $2, $0	         ;$2 = 00000S400
xor    $1, $2 	         ;$1 = 0000S8S400
movr   $3, $7     ;$3 = D4D3D2P4D1P2P1P0
movi   $2, #5
sll    $3, $2
slr    $0, $0
addi   $0, #-1
slr    $3, $0       ;$3 = 0000000P2
movr   $0, $7
movi    $4, #6
slr	   $0, $4	       ;$0 = 000000D4D3
rxor   $0, $0	       ;$0 = D4 ^ D3
movr   $4, $7
addi   $2, #-1
sll	   $4, $2
movi    $2, #7
slr    $4, $2 	  ;$4 = D1
movi   $2, #4
xor    $0, $4  	  ;$0 = D4 ^ D3 ^ D1
xor    $3, $0 	  ;$3 = D4 ^ D3 ^ D1^ P2
movr   $4, $6 	  ;$4 =  D11D10D9D8D7D6D5P8 
movi   $0, #3      ;$0 = 00000011
sll    $0, $2          ;$0 = 00110000
addi   $0, #1
addi   $0, #1
addi   $0, #1       ;$0 = 00110011
addi   $2, #-2
sll    $0, $2	;$0 = 11001100
and    $0, $4        ;$0 = D11D1000D7D600
rxor   $0, $0 	   ;$0 = D11^ D10^ D7^D6
xor    $3, $0          ;$3 = D11^ D10^ D7^D6^D4 ^ D3 ^ D1^ P2= S2
movi   $4, #1
slr    $3, $4 	  ;$3 = 000000S20
xor    $1, $3	   ;$1 = 0000S8S4S20
movr   $4, $6	  ;$4 =  D11D10D9D8D7D6D5P8  
movi   $0, #1
sll    $0, $2
addi   $0, #1  	  ;$0 = 00000101
sll    $0, $2
addi   $0, #1  	  ;$0 = 00010101
sll    $0, $2
addi   $0, #1  	  ;$0 = 01010101
addi   $2, #-1
sll    $0, $2 	  ;$0 = 10101010
and    $4, $0 	  ;$4 = D110D90D70D50
rxor   $4, $4 	  ;$4 = D11 ^D9 ^D7^D5
movi   $0, #1
addi   $2, #1
sll    $0, $2
addi   $0, #1  	  ;$0 = 00000101
sll    $0, $2
addi   $0, #1  	  ;$0 = 00010101
addi   $2, #1
sll    $0, $2	  ;$0 = 10101000
movr   $2, $7 	  ;$2 = D4D3D2P4D1P2P1P0
and    $2, $0
rxor   $2, $2     ;$2 = D4 ^D2 ^D1
xor    $2, $4 		  ;$2 =  D11 ^D9 ^D7^D5 ^ D4 ^D2 ^D1= Q1
movr   $3, $7
movi   $4, #5
sll    $3, $4
movi   $4, #7
slr    $3, $4 		  ;$3 = P1
movi   $4, #5
xor    $3, $2 		  ;$3 = P1 ^ Q1 = S1
xor    $1, $3 		  ;$1 = 0000S8S4S2S1
movi   $4, #7
movi   $2, $4
movi   $4, #5
movr   $1, $4
lt 	   $4, $2
movi   $0, #0
movr   $2, $7
movr   $3, $1
;bt    $4,FIRSTBYTE

SECONDBYTE:
movr   $2, $6
movi   $4, #-1
addi   $4, #-2
addi   $4, #-2
addi   $4, #-2
add    $1, $4
movr   $3, $1

eq 	    $0, $3
;bt 	$0, STOREBYTE2
add 	$2, $2
addi 	$3, #-1
eq 	    $0, $3
;bt 	$0, STOREBYTE2
movi    $4, #1
;bt 	$4,SECONDBYTE


STOREBYTE:2
movi 	$3, #1
xor 	$2, $3
movr    $4, $6
movr 	$3, $1
LOOP2:
movi 	$0, #0
eq      $0, $1
;bt  	$0,END2
add  	$2, $2
addi  	$1, #-1
movi  	$0, #1  
;bt  	$0, LOOP2

END2:
movi  	$1, #1
addi  	$1, #2
addi  	$1, #2
addi  	$1, #2
sub  	$1, $3
sll  	$4, $1
slr  	$4, $1
xor  	$2, $4 
movr  	$6, $2

movr  	$1, $7
movi    $0, #3
slr  	$1, $0
movi 	$2, #1
and 	$2, $1
addi    $0, #-1
slr 	$1, $0
add 	$1, $1
xor 	$1, $2 			  ;$1 = 0000D4D3D2D1
movr 	$3, $6
add 	$3, $3
movi 	$4, #1
addi  	$4, #2
addi  	$4, #2
addi  	$4, #2
addi  	$4, #1
addi  	$4, #2
addi  	$4, #2
addi  	$4, #2
addi  	$4, #1
and 	$4, $3
movi     $3, #4
slr 	$4, $3  	  ;$4 = D8D7D6D50000
xor 	$1, $4 		  ;$1 = D8D7D6D5D4D3D2D1
movr    $3, $7 		
movi 	$2, #1
movi   	$4, #1
addi 	$4, #2
addi    $4, #2
addi    $4, #1
sll 	$2, $4
addi 	$4, #-1
slr 	$3, $4
xor 	$3, $2           ;$3 = 01000D11D10D9
sb      $1, $5
addi 	$5, #1
sb 	    $3, $5
addi    $5, #1


FIRSTBYTE:
eq 	    $0, $3
;bt 	$0, STOREBYTE1
add 	$2, $2
addi 	$3, #-1
eq 	    $0, $3
;bt 	$0, STOREBYTE1
movi    $4, #1
;bt 	$4,FIRSTBYTE




STOREBYTE1:
movi 	$3, #1
xor 	$2, $3
movr    $4, $7
movr 	$3, $1
LOOP:
movi   $0, #0
eq     $0, $1
;bt    $0,END1
add    $2, $2
addi   $1, #-1
movi   $0, #1
;bt    $0, LOOP
END1:
movi   $1, #1
addi   $1, #2
addi   $1, #2
addi   $1, #2
sub    $1, $3
sll    $4, $1
slr    $4, $1
xor    $2, $4 
movr   $7, $2

movr  	$1, $7
movi    $0, #3
slr  	$1, $0
movi 	$2, #1
and 	$2, $1
addi    $0, #-1
slr 	$1, $0
add 	$1, $1
xor 	$1, $2 			  ;$1 = 0000D4D3D2D1
movr 	$3, $6
add 	$3, $3
movi 	$4, #1
addi  	$4, #2
addi  	$4, #2
addi  	$4, #2
addi  	$4, #1
addi  	$4, #2
addi  	$4, #2
addi  	$4, #2
addi  	$4, #1
and 	$4, $3
movr    $3, #4
slr 	$4, $3  	  ;$4 = D8D7D6D50000
xor 	$1, $4 		  ;$1 = D8D7D6D5D4D3D2D1
movr    $3, $7 		
movi 	$2, #1
movi   	$4, #1
addi 	$4, #2
addi 	$4, #2
addi    $4, #1
sll 	$2, $4
addi 	$4, #-1
slr 	$3, $4
xor 	$3, $2           ;$3 = 01000D11D10D9
sb      $1, $5
addi 	$5, #1
sb 	    $3, $5
addi 	$5, #1


