#set memory word 0($gp) = [5,4,3,7,1]
or      $a0, $zero, $gp                     ; arr[]
addi    $a1, $zero, 5                       ; n = 5

jal bubbleSort
jal printArray

#stop

;
;// A function to implement bubble sort 
;void bubbleSort(int arr[], int n) 
;{ 
;    // Base case 
;    if (n == 1) 
;        return; 
;  
;    // One pass of bubble sort. After 
;    // this pass, the largest element 
;    // is moved (or bubbled) to end. 
;    for (int i=0; i<n-1; i++) 
;        if (arr[i] > arr[i+1]) 
;            swap(arr[i], arr[i+1]); 
;  
;    // Largest element is fixed, 
;    // recur for remaining array 
;    bubbleSort(arr, n-1); 
;} 
;

printArray:
    addi    $t0, $zero, 0                  ;i=0

for2:
    slt     $t1, $t0, $a1                  ;i < n 
    beq     $t1, $zero, return
    
    sll     $t1, $t0, 2
    add     $t1, $a0, $t1

    lw      $t1, 0($t1)
    #show   $t1

    addi    $t0, $t0, 1                    ;i++
    j       for2

return:
    jr      $ra


bubbleSort:

    addi    $sp, $sp, -8                    ; make space for ra and the parameter n
    sw      $ra, 0($sp)
    sw      $a1, 4($sp)

    ;Caso base
    addi    $t0, $zero, 1
    beq     $a1, $t0, returnFunction        ;if(n == 1)

    ; else
    addi    $t1, $zero, 1                   ;i = 0
    addi    $t2, $a1, -1                    ;t2 = n-1

for:
    slt     $t3, $t1, $t2
    beq     $t3, $zero, nextPartOfCode            ; if i >= n - 1, exit loop

    sll     $t4, $t1, 2
    add     $t4, $t4, $a0                   ; i iterator
    addi    $t5, $t4, 4                     ; i + 1 iterator

    lw      $t6, 0($t4)                     ; arr[i]
    lw      $t7, 0($t5)                     ; arr[i+1]

    slt     $t8, $t7, $t6                   ;arr[i] > arr[i+1]
    beq     $t8, $zero, nextIteration       

    ;Swap
    add     $s0, $zero, $t6                 ;temp1 = arr[i]
    add     $s1, $zero, $t7                 ;temp2 = arr[i+1]
    sw      $s0, 0($t5)                     ;arr[i+1] = arr[i]
    sw      $s1, 0($t4)                     ;arr[i] = arr[i+1]
    j       nextIteration

nextIteration:
    addi    $t1, $t1, 1                     ;i++
    j       for


nextPartOfCode:
    addi    $a1, $a1, -1                    ;n-1
    jal     bubbleSort


returnFunction:
    lw      $ra, 0($sp)
    lw      $a1, 4($sp)
    addi    $sp, $sp, 8
    jr      $ra

;#exec "Programs/MIPS/recursiveBubbleSort.asm"