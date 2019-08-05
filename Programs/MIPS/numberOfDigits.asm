addi    $a0, $zero, 1111
jal     number_of_digits
#show $v0
#stop

number_of_digits:
    addi    $v0, $zero, 0
    addi    $t1, $zero, 10                  ;constant 10

while:
    beq     $a0, $zero, endOfFunction
    div     $a0, $t1
    mflo    $a0
    addi    $v0, $v0, 1
    j       while

endOfFunction:
    jr      $ra

;#exec "Programs/MIPS/numberOfDigits.asm"