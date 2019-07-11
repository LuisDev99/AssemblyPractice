#set memory word 0($gp) = [1,2,3,4,5]
or      $a0, $zero, $gp
addi    $a1, $zero, 5                   ;size = 5

jal reversePrint
#stop

;DOES NOT WORK BUT THATS BECAUSE THE CODE I TRANSLATED WAS WRONG

reversePrint:

    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    jal     getReverse
    addi    $t0, $zero, 0               ;i = 0

Loop1:
    slt     $t1, $t0, $a1
    beq     $t1, $zero, endLoop1
    
    sll     $t1, $t0, 2
    add     $t1, $a0, $t1
    lw      $t1, 0($t1)
    #show   $t1
    addi    $t0, $t0, 1

    j       Loop1

endLoop1:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra


getReverse:

    addi    $t0, $zero, 0               ;i=0
    
outerLoop:
    slt     $t1, $t0, $a1
    beq     $t1, $zero, endOfOuterLoop

    sll     $t1, $t0, 2
    add     $t1, $a0, $t1

    addi    $t3, $a1, -1
    add     $t2, $zero, $t3             ;j=size-1

innerLoop:

    bgez    $t2, innerLoopBody          ;j>= 0

    ;end of inner Loop
    addi     $t0, $t0, 1
    j       outerLoop

innerLoopBody:
    sll     $t3, $t2, 2
    add     $t3, $a0, $t3
    lw      $t4, 0($t3)                 ;t4 = a[j]
    lw      $t5, 0($t1)                 ;temp = a[i]

    sw      $t4, 0($t1)                 ;a[i] = a[j]
    sw      $t5, 0($t3)                 ;a[j] = temp;

    addi    $t2, $t2, -1     
    j		innerLoop
    

endOfOuterLoop:
    jr      $ra