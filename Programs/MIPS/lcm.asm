addi    $a0, $zero, 48                     ;n1 
addi    $a1, $zero, 3568                    ;n2 
jal lcm 
#show $v0   
#stop

;-------------------------------------------------------------------------------------|
; TESTS (First item in every tuple is n1, second item is n2, third item is the answer)|
; Change registers $a0 and $a1 to test every case                                     |
; std::vector<std::tuple<unsigned, unsigned, unsigned>> test_lcd = {                  |
;     {930, 1302, 6510},                                                              |
;     {2852, 18538, 37076},                                                           |
;     {1442, 3591, 739746},                                                           |    
;     {1920, 3368, 808320},                                                           |
;     {1279, 29417, 29417},                                                           |
;     {1693, 45711, 45711},                                                           |
;     {48, 3568, 10704},                                                              |
;     {1048, 418, 219032},                                                            |
;     {2890, 3170, 916130},                                                           |
;     {3665, 145, 106285},                                                            |
; };                                                                                  |
;-------------------------------------------------------------------------------------|

;--------------------------------------------------------------------|
; unsigned lcm(unsigned n1, unsigned n2)                             |
; {                                                                  |
;     unsigned minMultiple = (n1>n2) ? n1 : n2;                      |
;                                                                    |
;     while(true)                                                    |
;     {                                                              |
;         if((minMultiple % n1 == 0) && (minMultiple % n2 == 0)) {   |
;             break;                                                 |
;         }                                                          |
;         ++minMultiple;                                             |
;     }                                                              |
;     return minMultiple;                                            |
; }                                                                  |
;--------------------------------------------------------------------|

lcm:    
    sltu    $t0, $a1, $a0   
    beq     $t0, $zero, elseOfTernary       ;minMultiple = (n1>n2) ? n1 : n2
    addu    $v0, $zero, $a0                 ;minMultiple = n1
    j       restOfFunction    

elseOfTernary:  
    addu    $v0, $zero, $a1                 ;minMultiple = n2
    j       restOfFunction    

restOfFunction: 
    divu    $v0, $a0    
    mfhi    $t0                             ;t0 = minMultiple % n1

    bne     $t0, $zero, incrementMultiple   ;(minMultiple % n1 == 0)

    divu    $v0, $a1    
    mfhi    $t0                             ;t0 = minMultiple % n2

    bne     $t0, $zero, incrementMultiple   ;(minMultiple % n2 == 0)

    ;break
    jr	    $ra					            ;return
    

incrementMultiple:
    addiu   $v0, $v0, 1                     ;++minMultiple
    j       restOfFunction

;#exec "Programs/MIPS/lcm.asm"