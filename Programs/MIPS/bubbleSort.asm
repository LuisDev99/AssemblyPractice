#set memory word 0($gp) = [94, 42, 50, 95, 333, 65, 54, 456, 1, 1234]
or      $a0, $zero, $gp                 ;*array
addi    $a1, $zero, 10                  ;n = 10
jal     bubbleSort
jal     printArray
#stop

;---------------------------------------|
; void printArray(int *array, int n){   |
;     for(int i = 0; i < n; i++){       |
;         cout << array[i] << endl;     |
;     }                                 |
; }                                     |
;---------------------------------------|

;-------------------------------------------|  
; void BubbleSort(int *array, int n) {      |      
;   bool swapped = true;                    |
;   int j = 0;                              |
;   int temp;                               |                                   
;                                           |             
;   while (swapped) {                       |
;     swapped = false;                      |
;     j++;                                  |
;     for (int i = 0; i < n - j; ++i) {     |
;       if (array[i] > array[i + 1]) {      |
;         temp = array[i];                  |
;         array[i] = array[i + 1];          |
;         array[i + 1] = temp;              |
;         swapped = true;                   |
;       }                                   |
;     }                                     |
;   }                                       |
; }                                         |
;-------------------------------------------| 

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

bubbleSort: 
    addi    $t0, $zero, 1               ;swapped = true
    ;t2 = temp
    addi    $t1, $zero, 0           ;j = 0

while:
    beq     $t0, $zero, endOfFunction   ;while(swapped) = $t0 != 0

    addi    $t0, $zero, 0               ;swapped = false
    addi    $t1, $t1, 1                 ;j++

    addi    $t3, $zero, 0               ;i = 0
    sub     $t4, $a1, $t1               ;t4 = n - j (will be used to validate later on)

for:
    slt     $t5, $t3, $t4               ;i < n - j
    beq     $t5, $zero, endOfFor

    sll     $t6, $t3, 2                 ;iterator
    add     $t6, $a0, $t6               

    addi    $t7, $t6, 4                 ;[i+1] which is done by using the iterator + 4 which will get use the next word

    lw      $t8, 0($t6)                 ;t8 = array[i]
    lw      $t9, 0($t7)                 ;t9 = array[i+1]

    slt     $s0, $t9, $t8               ;array[i] > array[i + 1]
    beq     $s0, $zero, nextIteration   

    add     $t2, $zero, $t8             ;temp = array[i]
    sw      $t9, 0($t6)                 ;array[i] = array[i + 1]
    sw      $t2, 0($t7)                 ;array[i + 1] = temp
    addi    $t0, $zero, 1               ;swapped = true
    j       nextIteration               ;for better readability
    
nextIteration:
    addi    $t3, $t3, 1                 ;i++
    j       for

endOfFor:
    j       while

endOfFunction:
    jr      $ra

;#exec "Programs/MIPS/bubbleSort.asm"