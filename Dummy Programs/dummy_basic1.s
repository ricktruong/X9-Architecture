movi $2,#0  ; 
lb   $2,$2  ;
movi $1,#3  ;
sb   $1,$2 ;
addi $2,#1 ;
movr $5,$2 ;
movi $0,#2 ;
sb   $0,$1 ;
movr $3,$6 ;
movi $4,#1 ;
   :sll  $1,$0 ;
   :slr  $1,$0 ;
   :movi $0,#1 ; 
   :lb   $0,$1 ; 
   :movr $2,$5 ; 
   :add  $2,$1 ; 
   :add  $2,$1 ; 
   :sub  $2,$1 ; 
   :movr $5,$2 ; 
   :sb   $0,$1 ; 
   :movi $0,#6 ;
   :lb   $0,$1 ;
   :addi $0,#1  ;
   :lb   $0,$2 ;
   :movr $2, $6 ;
   :and $2, $1 ;
   :movr $7, $2 ;
   :movi $0, #4 ;
   :sb   $0, $3 ;
   :movr $2, $7  ;
   :or   $2,$1 ;
   :movi $0, #5 ;
   :movr $7, $2 ;
   :sb   $0, $3 ;
   :movr $2, $7 ;
   :movi $0, #7 ;
   :addi $0, #1 ;
   :xor  $2,$1 ;
   :movr $7, $2 ;
   :sb   $0, $3 ;
   :movr $2, $7 ;
   :addi $0, #1 ;
   :nor  $2,$1 ;
   :movr $7, $2 ;
   :sb   $0, $3 ;
   :movr $2, $7 ;
   :addi $0, #1;
   :movr $7, $0;
   :eq   $2, $2 ;
   :movr $2, $7;
   :movr $7, $0 ;
   :sb   $2, $3 ;
   :addi $2,#1  ;
   :movr $7, $2 ;
   :movr $2, $5;
   :lt   $2, $2 ;
   :movr $2, $7 ;
   :movr $7, $0 ;
   :sb   $2, $3 ;
   :addi $2, #1 ;
   :movr $7, $2 ;
   :movr $2, $5 ;
   :rxor $2, $2 ;
   :movr $0, $7 ;
   :movr $7, $2 ;
   :sb   $0, $3 ;




 :   : :or  $2, $1 ;
 :   : :xor $2, $1 ;
 :   : :nor $2, $1 ;
 :   : :movr $7, $2 ;
 :   : :movi $0, #4 ;
 :   : :sb  $0, $3 ; 
 :   : :eq  $2, $3 ;
 :   : :lt  $0, $1 ;





