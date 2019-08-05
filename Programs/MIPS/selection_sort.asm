#set memory word 0($gp) = [91, 96, 48, 1, 8, 52, 9, 24, 45, 9]
or      $a0, $zero, $gp                    ;arr[]
addi    $a1, $zero, 10                     ;n = 10

jal selection_sort

addi    $a1, $zero, 10                     ;n = 10

jal printArray

#stop

printArray:
    addi    $t0, $zero, 0               ;i=0

fori2:
    slt     $t1, $t0, $a1               ;i < n 
    beq     $t1, $zero, return
    
    sll     $t1, $t0, 2
    add     $t1, $a0, $t1

    lw      $t1, 0($t1)
    #show   $t1

    addi    $t0, $t0, 1                 ;i++
    j       fori2

return:
    jr      $ra


selection_sort:
    addi    $t0, $zero, 0               ;int c = 0
    addi    $t1, $a1, -1                ;n-1

for:    
    slt     $t2, $t0, $t1               ;c < (n-1)
    beq     $t2, $zero, endOfFunc   

    addi    $t2, $t0, 0                 ;int position = c (reusing t2)

    addi    $t3, $t0, 1                 ;int d = c + 1

for2:   
    slt     $t4, $t3, $a1               ;d < n
    beq     $t4, $zero, endFor2 

    sll     $t4, $t2, 2                 ;iterator position (reusing t4)
    sll     $t5, $t3, 2                 ;iterator d

    add     $t4, $a0, $t4               ;&arr + iterator position
    add     $t5, $a0, $t5               ;&arr + iterator end

    lw      $t4, 0($t4)                 ;array[position]
    lw      $t5, 0($t5)                 ;array[d]

    slt     $t5, $t5, $t4               ;if(array[position] > array[d])
    beq     $t5, $zero, nextFor2Cycle 

    add     $t2, $zero, $t3             ;position = d
    j       nextFor2Cycle

nextFor2Cycle:    
    addi    $t3, $t3, 1                 ;d++
    j       for2



endFor2:
    ;Rest of the function
    beq     $t0, $t2, nextForCycle      ;if(position != c)

    sll     $t4, $t0, 2                 ;iterator c
    sll     $t5, $t2, 2                 ;iterator position

    add     $t4, $a0, $t4
    add     $t5, $a0, $t5

    lw      $t6, 0($t4)                 ;int swap = array[c]
    lw      $t7, 0($t5)                 ;t7 = array[position]

    sw      $t7, 0($t4)                 ;array[c] = array[position]
    sw      $t6, 0($t5)                 ;array[position] = swap
    j       nextForCycle

nextForCycle:
    addi    $t0, $t0, 1
    j       for


endOfFunc:
    jr      $ra

;#exec "Programs/MIPS/selection_sort.asm"