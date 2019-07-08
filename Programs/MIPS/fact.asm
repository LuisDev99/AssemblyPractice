addi    $a0, $zero, 3 ;parametro n al registro a0 por convencion
jal     fact

#show $v0             ;registro que tendra el valor de retorno de la funcion factorial
#stop

;------------------------------------------------|
;   int fact(int n){                             |
;     if(n == 0 || n == 1)                       |
;       return 1;                                |
;     else                                       |
;       return n * fact(n-1);                    |
;   }                                            |
;------------------------------------------------|

fact:
    addi    $sp, $sp, -8            ;Backup registro n y el return address
    sw      $a0, 0($sp)
    sw      $ra, 4($sp)

    ;Caso base
    beq     $a0, $zero, returnOne   ;n == 0
    beq     $a0, $t1, returnOne     ;n == 1

    ;else
    addi    $a0, $a0, -1 ;n = n-1
    jal     fact

    lw      $a0, 0($sp)
    lw      $ra, 4($sp)

    mult    $a0, $v0			    ; $a0 * $v0 = Hi and Lo registers
    mflo	$v0					    ; copy Lo to $v0  ;return n * fact(n-1);
    
    addi    $sp, $sp, 8
    jr      $ra
    
    #stop

returnOne:
    addi    $v0, $zero, 1           ; return 1
    lw      $a0, 0($sp)
    lw      $ra, 4($sp)
    addi    $sp, $sp, 8
    jr      $ra


;#exec "Programs/fact32.asm"
