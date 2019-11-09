call main
#stop

;-------------------------------------------------------------------------------------|
; TESTS (First item in every tuple is n1, second item is n2, third item is the answer)|
; In main function, push first n2, and then n1 to test                                |
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
    ;epilogue
    push    ebp
    mov     ebp, esp

    mov     eax, [ebp + 8]                  ;n1
    
    cmp     eax, [ebp + 12]                 ;n1 > n2

    jg      minMultiple_n1

    push    [ebp + 12]                      ;minMultiple = n2

    jmp     while

minMultiple_n1:
    push    eax                             ;minMultiple = n1
    jmp     while

while:

    mov     eax, [ebp - 4]                  ;dividendo minMultiple
    mov     ecx, [ebp + 8]                  ;divisor n1
    cdq
    div     ecx

    cmp     edx, 0
    jne     continue

    mov     eax, [ebp - 4]                  ;dividendo minMultiple
    mov     ecx, [ebp + 12]                  ;divisor n1
    cdq
    div     ecx

    cmp     edx, 0
    jne     continue

    jmp     end_of_function

continue:
    inc     [ebp - 4]                       ;++minMultiple
    jmp     while

end_of_function:
    pop     eax                             ;clean the local variable minMultiple

    ;prologue
    mov esp, ebp
    pop ebp

    ret

main:
    push 18538
    push 2852
    call lcm

    #show eax

    add esp, 4
    ret

;#exec "Programs/x86/lcm.asm"