main:
    li      $s0, 10 ;Pseudo Instruction "li"
    li      $s1, 20 ;Pseudo Instruction "li"
    add     $t0, $s0, $s1
    jal     printer
    #show   $s1
    #stop

printer:

    ;Back up del registro ra y $s1 moviendo el stack pointer hacia abajo 8 bytes (para hacer espacio de 4 bytes para cada registro) porque se llamara otra funcion
    addi    $sp, $sp, -8
    sw      $ra, 0($sp) ;En la primera posicion de 0-3 guardar el valor que tiene $ra
    sw      $s1, 4($sp) ;En la segunda posicion de 4-8 guardar el valor que tiene $s1

    addi    $s1, $s1, 1
    #show   $s1
    #show   $t0
    jal     printer2

    ;Restore el registro ra y $s1 de la stack y limpiar el stack moviendo el stack pointer hacia arriba
    lw      $ra, 0($sp) ;Leer el valor que esta en la pila en la primera posicion y darselo a $ra
    lw      $s1, 4($sp) ;Leer el valor que esta en la pila en la segunda posicion y darselo a $s1
    addi    $sp, $sp, 8

    jr      $ra

printer2:
    #show   $s0
    jr      $ra