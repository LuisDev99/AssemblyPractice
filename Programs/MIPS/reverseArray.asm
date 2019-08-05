#set memory word 0($gp) = [1,2,3,4,5,6]
add     $a0, $zero, $gp                     ;int arr[]
addi    $a1, $zero, 0
addi    $a2, $zero, 5

jal     reverseArray

addi    $a1, $zero, 6

jal     printArray
#stop

printArray:
    addi    $t0, $zero, 0               ;i=0

for2:
    slt     $t1, $t0, $a1               ;i < n 
    beq     $t1, $zero, return
    
    sll     $t1, $t0, 2
    add     $t1, $a0, $t1

    lw      $t1, 0($t1)
    #show   $t1

    addi    $t0, $t0, 1                 ;i++
    j       for2

return:
    jr      $ra

reverseArray:

while:
    slt     $t0, $a1, $a2                   ;start < end
    beq     $t0, $zero, endOfFunction

    sll     $t0, $a1, 2                     ;iterator
    sll     $t1, $a2, 2                     ;iterator
    
    add     $t0, $a0, $t0                   ;&arr[start]
    add     $t1, $a0, $t1                   ;&arr[end]

    lw      $t2, 0($t0)                     ;temp = arr[start]
    lw      $t3, 0($t1)                     ;t3 = arr[end]

    sw      $t3, 0($t0)                     ;arr[start] = arr[end]
    sw      $t2, 0($t1)                     ;arr[end] = temp

    addi    $a1, $a1, 1                     ;start++
    addi    $a2, $a2, -1                    ;end--
    j       while


endOfFunction:
    jr      $ra

;#exec "Programs/MIPS/reverseArray.asm"
