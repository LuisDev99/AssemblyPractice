;
;int isEven(int n) {
;
;    return (n & 1) == 0;
;
;}
;

iseven:
    andi    $v0, $a0, 1
    bne     $v0, $zero, ReturnZero
    addi    $vo, $zero, 1
    j       end_is_even

ReturnZero:
    move    $v0, $zero

end_is_even:
    jr      $ra


main:
    addi    $a0, $zero, 2
    jal     iseven
    #show   $v0

    #stop