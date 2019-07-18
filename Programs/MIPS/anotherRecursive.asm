addi    $a0, $zero, 3                   ;test = 3
jal     printFun
#stop

;-----------------------------------------------|
; void printFun(int test)                       |
; {                                             |
;     if (test < 1)                             |
;         return;                               |
;     else                                      |
;     {                                         |
;         cout << test << " ";                  |
;         printFun(test-1);    // statement 2   |
;         cout << test << " ";                  |
;         return;                               |
;     }                                         |
; }                                             |
;                                               |
; int main()                                    |
; {                                             |
;     int test = 3;                             |
;     printFun(test);                           |
; }                                             |
;-----------------------------------------------|

printFun:

    addi    $sp, $sp, -8
    sw      $ra, 0($sp)
    sw      $a0, 4($sp)

    ;Caso Base
    slti    $t0, $a0, 1                 ;if test < 1
    bne     $t0, $zero, endRecursion

    ;else

    #show $a0                           ;cout << test << " "

    addi    $a0, $a0, -1                ;test-1

    jal     printFun                    ;printFun(test-1)

    lw      $ra, 0($sp)
    lw      $a0, 4($sp)
    addi    $sp, $sp, 8

    #show $a0                           ; cout << test << " "

    jr      $ra


endRecursion:
    lw      $ra, 0($sp)
    lw      $a0, 4($sp)
    addi    $sp, $sp, 8
    jr      $ra

;#exec "Programs/MIPS/anotherRecursive.asm"