PROGRAM_1:
    movi    $0, #0                  ; Initialize i = 0 ($0);


LOAD_MESSAGE:                       ; while (i < 30) {
    lb      $0, $4                      ; $4 = mem[i];
    movr    $1, $4                      ; $1 = $4;
    addi    $0, #1                      ; i++;
    lb      $0, $5                      ; $5 = mem[1];
    movr    $2, $5                      ; $2 = $5;
    