#set memory word 0($gp) = [1,2,3,4,5]
or      $a0, $zero, $gp                 ;move $a0, $gp
addi    $a1, $zero, 5                   ;size of the array = 5

jal traverseArray
#stop


traverseArray:
    ;I used t1 for comparison, multiplication, as iterator and to hold the value of an element in the array. Optimize?

    addi    $t0, $zero, 0               ;iterator, i = 0

Loop:
    slt     $t1, $t0, $a1               ;check to see if i is less than array size
    beq     $t1, $zero, endOfLoop       ;if t1 is zero, then we reached the end of the loop

    sll     $t1, $t0, 2                 ;multiply by four (using left shifting) to get the corresponding word in the array
    add     $t1, $a0, $t1               ;t1 = &array + (iterator * 4)
    lw      $t1, 0($t1)                 ;t1 = array[i]
    #show   $t1
    addi    $t0, $t0, 1                 ;i++
    j Loop

endOfLoop:
    jr $ra
    
;#exec "Programs/MIPS/arrays.asm"