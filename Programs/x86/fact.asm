call main
#stop

;------------------------------------------------|
;   int fact(int n){                             |
;     if(n == 0 || n == 1)                       |
;       return 1;                                |
;     else                                       |
;       return n * fact(n-1);                    |
;   }                                            |
;------------------------------------------------|




;DOESNT WORK, ITS YOUR JOB TO FIND THE BUG :D GOOD LUCK





fact:
    ;epilogue
    push    ebp
    mov     ebp, esp

    
    ;if(n == 0 || n == 1)
    cmp     [ebp + 8], 0
    je      return_1

    cmp     [ebp + 8], 1
    je      return_1

    ;else
    mov     ebx, [ebp + 8]
    dec     ebx                         ;n-1
    push    ebx
    call    fact

    ;prologue
    mov     esp, ebp
    pop     ebp
    ;pop     esi

    imul    eax, [ebp + 8]
    #show eax
    ret     

return_1:

    mov     eax, 1

    ;prologue
    mov     esp, ebp
    pop     ebp

    ret

main:
    push    4
    call    fact
    pop     eci

    #show eax

    ret

;#exec "Programs/x86/fact.asm"