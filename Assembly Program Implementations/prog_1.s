PROGRAM_1:
    movi    $0, #1                  ; Initialize i = 0 ($0);


LOAD_MESSAGE:                       ; while (i < 30) {
    lb      $0, $4                      ; $4 = mem[i];
    movr    $1, $4                      ; $1 = $4;
    addi    $0, #1                      ; i++;
    lb      $0, $5                      ; $5 = mem[1];
    movr    $2, $5                      ; $2 = $5;


P8:
    movi    $4, #4                      ; $4 = 4;
    slr     $1, $4                      ; $1 =  b8  b7  b6  b5 _  b4  b3  b2  b1 >> 4;
    movi    $4, #1                      ; $4 = 1;
    sll     $1, $4                      ; $1 =   0   0   0   0 _  b8  b7  b6  b5 << 1;
    movi    $5, #5                      ; $5 = 5;
    sll     $2, $5                      ; $2 =   0   0   0   0 _   0 b11 b10  b9 << 5;
    movr    $6, $2                      ; $6 = b11 b10  b9   0 _   0   0   0   0;
    xor     $1, $6                      ; $1 =   0   0   0  b8 _  b7  b6  b5   0 ^ b11 b10  b9   0 _   0   0   0   0;
    rxor    $2, $1                      ; $2 =^b11 b10  b9  b8 _  b7  b6  b5   0;
    movr    $6, $2                      ; $6 =   0   0   0   0 _   0   0   0  p8;
    xor     $1, $6                      ; $1 = b11 b10  b9  b8 _  b7  b6  b5   0 ^   0   0   0   0 _   0   0   0  p8;

    movr    $7, $1                      ; $7 = b11 b10  b9  b8 _  b7  b6  b5  p8;


P4:
    slr     $1, $5                      ; $1 = b11 b10  b9  b8 _  b7  b6  b5  p8 >> 5;
    sll     $1, $5                      ; $1 =   0   0   0   0 _   0 b11 b10  b9 << 5;

    addi    $0, #-1                     ; i--;
    lb      $0, $4                      ; $4 = mem[i];
    movr    $2, $4                      ; $2 = $4;
    lb      $0, $4                      ; $4 = mem[i];
    movr    $3, $4                      ; $3 = $4;


    movi    $4, #7                      ; $4 = 7;
    slr     $2, $4                      ; $2 =  b8  b7  b6  b5 _  b4  b3  b2  b1 >> 7;
    movi    $4, #4                      ; $4 = 4;
    sll     $2, $4                      ; $2 =   0   0   0   0 _   0   0   0  b8 << 4;

    movr    $6, $2                      ; $6 =   0   0   0  b8 _   0   0   0   0;
    xor     $1, $6                      ; $1 = b11 b10  b9   0 _   0   0   0   0 ^   0   0   0  b8 _   0   0   0   0;


    sll     $3, $4                      ; $3 =  b8  b7  b6  b5 _  b4  b3  b2  b1 << 4;
    slr     $3, $5                      ; $3 =  b4  b3  b2  b1 _   0   0   0   0 >> 5;


    movr    $6, $3                      ; $6 =   0   0   0   0 _   0  b4  b3  b2;
    xor     $1, $6                      ; $1 = b11 b10  b9  b8 _   0   0   0   0 ^   0   0   0   0 _   0  b4  b3  b2


    movr    $6, $1                      ; $6 = b11 b10  b9  b8 _   0  b4  b3  b2;
    rxor    $2, $6                      ; $2 =^b11 b10  b9  b8 _   0  b4  b3  b2;

    sll     $2, $4                      ; $2 =   0   0   0   0 _   0   0   0  p4 << 4;
    sll     $3, $5                      ; $3 =   0   0   0   0 _   0  b4  b3  b2 << 5;
    movr    $6, $3                      ; $6 =  b4  b3  b2   0 _   0   0   0   0;
    xor     $2, $6                      ; $2 =   0   0   0  p4 _   0   0   0   0 ^  b4  b3  b2   0 _   0   0   0   0;

    movr    $6, $2                      ; $6 =  b4  b3  b2  p4 _   0   0   0   0;

P2:
    movr    $1, $7                      ; $1 = b11 b10  b9  b8 _  b7  b6  b5  p8;
    slr     $1, $5                      ; $1 = b11 b10  b9  b8 _  b7  b6  b5  p8 >> 6;

    movr    $2, $7                      ; $2 = b11 b10  b9  b8 _  b7  b6  b5  p8;
    movi    $4, #2                      ; $4 = 2;
    slr     $2, $4                      ; $2 = b11 b10  b9  b8 _  b7  b6  b5  p8 >> 2;
    sll     $2, $5                      ; $2 =   0   0 b11 b10 _  b9  b8  b7  b6 << 6;

    movr    $4, $2                      ; $4 =  b7  b6   0   0 _   0   0   0   0;
    xor     $1, $4                      ; $1 =   0   0   0   0 _   0   0 b11 b10 ^  b7  b6   0   0 _   0   0   0   0;

    movi    $4, #7                      ; $4 = 7;
    slr     $3, $4                      ; $3 = b4  b3  b2   0 _   0   0   0   0 >> 7;
    movi    $4, #5                      ; $4 = 5;
    sll     $3, $4                      ; $3 =  0   0   0   0 _   0   0   0  b4 << 5;

    movr    $4, $3                      ; $4 =   0   0  b4   0 _   0   0   0   0;
    xor     $1, $4                      ; $1 =  b7  b6   0   0 _   0   0 b11 b10 ^   0   0  b4   0 _   0   0   0   0;

    lb      $0, $5                      ; $5 = mem[i];
    movr    $2, $5                      ; $2 = $5;
    sll     $2, $5                      ; $2 =  b8  b7  b6  b5 _  b4  b3  b2  b1 << 6;
    movi    $5, #3                      ; $5 = 3;
    slr     $2, $5                      ; $2 =  b2  b1   0   0 _   0   0   0   0 >> 3;

    movr    $4, $2                      ; $4 =   0   0   0  b2 _  b1   0   0   0;
    xor     $1, $4                      ; $1 =  b7  b6  b4   0 _   0   0 b11 b10 ^  0   0   0  b2 _  b1   0   0   0;

    movr    $4, $1                      ; $4 =  b7  b6  b4  b2 _  b1   0 b11 b10;
    rxor    $3, $4                      ; $3 =^ b7  b6  b4  b2 _  b1   0 b11 b10;

    movi    $5, #2                      ; $5 = 2;
    sll     $3, $5                      ; $3 =   0   0   0   0 _   0   0   0  p2 << 2;

    xor     $3, $6                      ; $3 =   0   0   0   0 _   0  p2   0   0 ^  b4  b3  b2  p4 _   0   0   0   0;

    movi    $5, #4                      ; $5 = 4;
    sll     $2, $5                      ; $2 =   0   0   0  b2 _  b1   0   0   0 << 4;
    slr     $2, $5                      ; $2 =  b1   0   0   0 _   0   0   0   0 >> 4;

    movr    $4, $2                      ; $4 =   0   0   0   0 _  b1   0   0   0;
    xor     $3, $4                      ; $3 =  b4  b3  b2  p4 _   0  p2   0   0 ^   0   0   0   0 _  b1   0   0   0;

    movr    $6, $3                      ; $6 =  b4  b3  b2  p4 _  b1  p2   0   0;

P1:
    movr    $1, $7                      ; $1 = b11 b10  b9  b8 _  b7  b6  b5  p8;
    movi    $4, #7                      ; $4 = 7;
    slr     $1, $4                      ; $1 = b11 b10  b9  b8 _  b7  b6  b5  p8 >> 7;

    movi    $5, #5                      ; $5 = 5;
    movr    $2, $7                      ; $2 = b11 b10  b9  b8 _  b7  b6  b5  p8;
    slr     $2, $5                      ; $2 = b11 b10  b9  b8 _  b7  b6  b5  p8 >> 5;
    sll     $2, $4                      ; $2 =   0   0   0   0 _   0 b11 b10  b9 << 7;

    movr    $4, $2                      ; $4 =  b9   0   0   0 _   0   0   0   0;
    xor     $1, $4                      ; $1 =   0   0   0   0 _   0   0   0 b11 ^  b9   0   0   0 _   0   0   0   0;

    movr    $2, $7                      ; $2 = b11 b10  b9  b8 _  b7  b6  b5  p8;
    movi    $5, #4                      ; $5 = 4;
    sll     $2, $5                      ; $2 = b11 b10  b9  b8 _  b7  b6  b5  p8 << 4;
    movi    $5, #7                      ; $5 = 7;
    slr     $2, $5                      ; $2 =  b7  b6  b5  p8 _   0   0   0   0 >> 7;
    movi    $5, #1                      ; $5 = 1;
    sll     $2, $5                      ; $2 =  0   0   0   0 _   0   0   0   b7 << 1;

    movr    $4, $2                      ; $4 =   0   0   0   0 _   0   0  b7   0;
    xor     $1, $4                      ; $1 =  b9   0   0   0 _   0   0   0 b11 ^   0   0   0   0 _   0   0  b7   0;

    movr    $2, $7                      ; $2 = b11 b10  b9  b8 _  b7  b6  b5  p8;
    movi    $5, #6                      ; $5 = 6;
    sll     $2, $5                      ; $2 = b11 b10  b9  b8 _  b7  b6  b5  p8 << 6;
    movi    $5, #7                      ; $5 = 7;
    slr     $2, $5                      ; $2 =  b5  p8   0   0 _   0   0   0   0 >> 7;
    movi    $5, #2                      ; $5 = 2;
    sll     $2, $5                      ; $2 =  0   0   0   0 _   0   0   0   b5 << 2;

    movr    $4, $2                      ; $4 =   0   0   0   0 _   0  b5   0   0;
    xor     $1, $4                      ; $1 =  b9   0   0   0 _   0   0  b7 b11 ^   0   0   0   0 _   0  b5   0   0;

    movr    $2, $6                      ; $2 =  b4  b3  b2  p4 _  b1  p2   0   0;
    movi    $5, #7                      ; $5 = 7;
    slr     $2, $5                      ; $2 =  b4  b3  b2  p4 _  b1  p2   0   0 >> 7;
    movi    $5, #3                      ; $5 = 3;
    sll     $2, $5                      ; $2 =   0   0   0   0 _   0   0   0  b4 << 3;

    movr    $4, $2                      ; $4 =   0   0   0   0 _  b4   0   0   0;
    xor     $1, $4                      ; $1 =  b9   0   0   0 _   0  b5  b7 b11 ^   0   0   0   0 _  b4   0   0   0;

    movr    $2, $6                      ; $2 =  b4  b3  b2  p4 _  b1  p2   0   0;
    movi    $4, #2                      ; $4 = 2;
    sll     $2, $4                      ; $2 =  b4  b3  b2  p4 _  b1  p2   0   0 << 2;
    movi    $4, #7                      ; $4 = 7;
    slr     $2, $4                      ; $2 =  b2  p4  b1  p2 _   0   0   0   0 >> 7;
    movi    $5, #4                      ; $5 = 4;
    sll     $2, $5                      ; $2 =   0   0   0   0 _   0   0   0  b2 << 4;

    movr    $4, $2                      ; $4 =   0   0   0  b2 _   0   0   0   0;
    xor     $1, $4                      ; $1 =  b9   0   0   0 _   0  b5  b7 b11 ^   0   0   0  b2 _   0   0   0   0;

    movr    $2, $6                      ; $2 =  b4  b3  b2  p4 _  b1  p2   0   0;
    sll     $2, $5                      ; $2 =  b4  b3  b2  p4 _  b1  p2   0   0 << 4;
    movi    $5, #7                      ; $5 = 7;
    slr     $2, $5                      ; $2 =  b1  p2   0   0 _   0   0   0   0 >> 7;
    movi    $5, #5                      ; $5 = 5;
    sll     $2, $5                      ; $2 =   0   0   0   0 _   0   0   0  b1 << 5;

    movr    $4, $2                      ; $4 =   0   0  b1   0 _   0   0   0   0;
    xor     $1, $4                      ; $1 =  b9   0   0  b2 _  b4  b5  b7 b11 ^   0   0  b1   0 _   0   0   0   0;

    movr    $4, $1                      ; $4 =  b9   0  b1  b2 _  b4  b5  b7 b11;
    rxor    $3, $4                      ; $3 =^ b9   0  b1  b2 _  b4  b5  b7 b11;

    movi    $5, #2                      ; $5 = 1;
    sll     $3, $5                      ; $3 =   0   0   0   0 _   0   0   0  p2 << 1;

    xor     $3, $6                      ; $3 =   0   0   0   0 _   0   0  p1   0 ^  b4  b3  b2  p4 _  b1  p2   0   0;

    movr    $6, $3                      ; $6 =  b4  b3  b2  p4 _  b1  p2   p1   0;

P0:
    rxor    $2, $6                      ; $2 =^ b4  b3  b2  p4 _  b1  p2   p1  0;
    rxor    $3, $7                      ; $3 =^b11 b10  b9  b8 _  b7  b6  b5  p8;
    xor     $2, $3                      ; $2 =   0   0   0   0 _   0   0   0 p0a ^   0   0   0   0 _   0   0   0 p0b;
    xor     $2, $6                      ; $2 =   0   0   0   0 _   0   0   0  p0 ^  b4  b3  b2  p4 _  b1  p2   p1  0;
    movr    $6, $2                      ; $6 =  b4  b3  b2  p4 _  b1  p2   p1 p0;

STORE_MESSAGE:
    movi    $5, #6                      ; $5 = 6;
    add     $0, $5                      ; $0 = 0 + 6;
    add     $0, $5                      ; $0 = 6 + 6;
    add     $0, $5                      ; $0 = 12 + 6;
    add     $0, $5                      ; $0 = 18 + 6;
    add     $0, $5                      ; $0 = 24 + 6;
    sb      $0, $6                      ; mem[i] =  b4  b3  b2  p4 _  b1  p2   p1 p0;
    movi    $5, #1                      ; $5 = 1;
    add     $0, $5                      ; $0 = 30 + 1;
    sb      $0, $7                      ; mem[i] = b11 b10  b9  b8 _  b7  b6  b5  p8;

    movi    $5, #6                      ; $5 = 6;
    sub     $0, $5                      ; $0 = 31 - 6;
    add     $0, $5                      ; $0 = 25 - 6;
    add     $0, $5                      ; $0 = 19 - 6;
    add     $0, $5                      ; $0 = 13 - 6;
    add     $0, $5                      ; $0 = 7 - 6;
    movi    $5, #1                      ; $5 = 1;
    add     $0, $5                      ; $0 = 1 + 1;

    ; Alternative solution using Lookup Tables
    movi    $4, #-3                     ; $4 = 30;
    add     $0, $4                      ; $0 = i + 30;
    sb      $0, $6                      ; mem[i] =  b4  b3  b2  p4 _  b1  p2   p1 p0;
    addi    $0, #1                      ; $0 = i++;
    sb      $0, $7                      ; mem[i] = b11 b10  b9  b8 _  b7  b6  b5  p8;
    sub     $0, $4                      ; $0 = i - 30;
    addi    $0, #1                      ; $0 = i++;


LESS_THAN_30:
   ; USE LUT TO STORE COMMONLY USED IMMEDIATE VALUES INTO NEGATIVE IMMEDIATE VALUES (SINCE NEGATIVE IMMEDIATE VALUES AREN'T COMMONLY USED)
   ; immediateLookupTable = {
   ;   '-3' : '30'
   ; }
    movr    $1, $0                      ; $1 = i;
    movi    $4, #-3                     ; $4 = 30;
    lt      $1, $4                      ; $1 = i < 30;
    bt      $1, LOAD_MESSAGE            ; if ($1) branch LOAD_MESSAGE
