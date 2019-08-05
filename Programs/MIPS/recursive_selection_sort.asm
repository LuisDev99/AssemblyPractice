jal main
#stop

;-------------------------------------------|
;int get_min(int arreglo[], int n){         |
;    int min = arreglo[0];  min = 0!        |
;                                           |
;    for(int i = 0; i < n; i++){            |
;        if(arreglo[min] > arreglo[i])      |
;            min = i;                       |
;    }                                      |
;                                           |
;    return min;                            |
;}                                          |
;                                           |
;void selection_sort(int arreglo[], int n){ |
;    if(n>1){                               |
;        int pos = get_min(arreglo, n);     |
;                                           |
;        if(pos != 0){                      |
;            int temp = arreglo[0];         |
;            arreglo[0] = arreglo[pos];     |
;            arreglo[pos] = temp;           |
;        }                                  |
;                                           |
;        selection_sort(&arreglo[1], n-1);  |
;    }                                      |
;}                                          |
;-------------------------------------------|

main:
    addi    $sp, $sp, -24
    sw      $ra, 0($sp)

    addi    $t0, $zero, 5
    sw      $t0, 4($sp)
    addi    $t0, $zero, 10
    sw      $t0, 8($sp)
    addi    $t0, $zero, 3
    sw      $t0, 12($sp)
    addi    $t0, $zero, 7
    sw      $t0, 16($sp)
    addi    $t0, $zero, 44
    sw      $t0, 20($sp)

    add     $a0, $zero, $sp             ;int arreglo[]
    addi    $a0, $a0, 4                 ;we started storing the arrays values since offset 4 of the stack pointer, so increment to that offset to get to the first element of the array
    addi    $a1, $zero, 5               ;n = 5

    add     $t7, $zero, $a0
    add     $t8, $zero, $a1

    jal     selection_sort

    add     $a0, $zero, $t7
    add     $a1, $zero, $t8

    jal     printArray

    lw      $ra, 0($sp)
    addi    $sp, $sp, 24

    jr      $ra


selection_sort:

    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    addi    $t0, $zero, 1               ;$t0 = 1
    slt     $t0, $t0, $a1               ;if(n>1)

    beq     $t0, $zero, endOfFunction

    jal     get_min

    add     $t0, $zero, $v0             ;int pos = get_min(arreglo, n)

    beq     $t0, $zero, afterIf         ;if(pos != 0)

    sll     $t1, $zero, 2               ;iterator for arreglo[0]
    sll     $t2, $t0, 2                 ;iterator for arreglo[pos]

    add     $t1, $t1, $a0               ;iterator + &arreglo
    add     $t2, $t2, $a0               ;iterator + &arreglo

    lw      $t3, 0($t1)                 ;int temp = arreglo[0]
    lw      $t4, 0($t2)                 ;t4 = arreglo[pos]

    sw      $t4, 0($t1)                 ;arreglo[0] = arreglo[pos]
    sw      $t3, 0($t2)                 ;arreglo[pos] = temp

    j       afterIf


afterIf:
    addi    $a0, $a0, 4                 ;&arreglo[1]
    addi    $a1, $a1, -1                ;n-1

    jal     selection_sort
    j       endOfFunction

endOfFunction:
    lw      $ra, 0($sp)
    addi    $sp, $sp, 4
    jr      $ra


get_min:
    add     $v0, $zero, $zero

    addi    $t0, $zero, 1               ;int i = 1

for_s:
    slt     $t1, $t0, $a1               ;i < n
    beq     $t1, $zero, returnMin

    sll     $t2, $v0, 2                 ;iterator arreglo[min]
    sll     $t3, $t0, 2                 ;iterator arreglo[i]

    add     $t2, $a0, $t2
    add     $t3, $a0, $t3

    lw      $t2, 0($t2)                 ;arreglo[min]
    lw      $t3, 0($t3)                 ;arreglo[i]

    slt     $t3, $t3, $t2               ;if(arreglo[min] > arreglo[i])
    beq     $t3, $zero, next_loop

    add     $v0, $zero, $t0             ;min = i


next_loop:
    addi    $t0, $t0, 1
    j       for_s


returnMin:
    jr      $ra                         ;return min


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


;#exec "Programs/MIPS/recursive_selection_sort.asm"