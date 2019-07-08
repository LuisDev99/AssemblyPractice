addi    $a0, $zero, 5395         ;a
addi    $a1, $zero, 9230         ;b
jal     gcd
#show   $v0
#stop

;------------------------------------------------------------------------------------|
; TESTS (First item in every tuple is a, second item is b, third item is the answer) |
; Change registers $a0 and $a1 to test every case                                    |
;                                                                                    |
; std::vector<std::tuple<unsigned, unsigned, unsigned>> tests = {                    |
;     {134, 567, 1},                                                                 |
;     {132, 567, 3},                                                                 |
;     {51492, 20636, 28},                                                            |
;     {53316, 33876, 36},                                                            |
;     {5416, 9236, 4},                                                               |
;     {5416, 9232, 8},                                                               |
;     {5406, 9231, 51},                                                              |
;     {5395, 9230, 65},                                                              |
; };                                                                                 |
;------------------------------------------------------------------------------------|

;--------------------------| 
; int gcd(int a, int b)    |
; {                        |
;     while (a != b) {     |
;         if (a > b) {     | 
;             a = a - b;   |
;         } else {         |
;             b = b - a;   |
;         }                |
;     }                    |
;     return a;            |
; }                        |
;--------------------------|


gcd:
    bne	    $a0, $a1, whileBody	    ;if $a0 != $a1 then whileBody
    add     $v0, $zero, $a0         ;set the return value equal to a
    jr      $ra                     ;return a

whileBody:
    slt     $t0, $a1, $a0           ; t0 = b < a
    beq     $t0, $zero, elseBody    ; if b is not less than a
    sub	    $a0, $a0, $a1		    ; a = a - b;
    j       gcd

elseBody:
    sub	    $a1, $a1, $a0           ; b = b - a
    j       gcd

;#exec "Programs/MIPS/gcd.asm"