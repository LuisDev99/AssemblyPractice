addi    $a0, $zero, 3               ;base
addi    $a1, $zero, 3               ;exp
jal     exp 
#show   $v0                         ;registro que contiene el valor de retorno
#stop

;--------------------------------------------|
; int exp_r(int base, int exp, int res){     |
;     if(exp == 0) return res;               |
;     return exp_r(base, exp-1, res*base);   |
; }                                          |
;                                            |
; int exp(int base, int exp){                |
;     return exp_r(base, exp-1, base);       |
; }                                          |
;--------------------------------------------|


exp: 
    addi    $sp, $sp, -4            ;allocate 4 bytes to save ra
    sw      $ra, 0($sp) 

    addi    $a1, $a1, -1            ;exp = exp - 1
    add     $a2, $zero, $a0         ;res = base    
    jal     exp_r                   ;call the recursive function

    lw		$ra, 0($sp) 
    addi    $sp, $sp, 4		    

    jr		$ra	                    ;jump to $ra

exp_r:
    addi    $sp, $sp, -4
    sw      $ra, 0($sp)

    ;Caso base
    beq     $a1, $zero, returnRes  ;exp == 0

    ;else
    addi    $a1, $a1, -1            ;exp = exp - 1
    mult	$a0, $a2			    ;$a0 * $a1 = Hi and Lo registers
    mflo	$a2					    ;copy Lo to $a2
    jal     exp_r

    lw      $ra, 0($sp)
    addi    $sp, $sp, 4

    jr      $ra
    
returnRes:
    lw      $ra, 0($sp)
    add     $v0, $zero, $a2         ;return res
    jr      $ra

;#exec "Programs/recursiveExponent32.asm"