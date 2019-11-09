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


fact:
    ;epilogue
    push    ebp
    mov     ebp, esp

    ;if(n == 0 || n == 1)
    cmp     [ebp + 8], 0
    je      return1

    cmp     [ebp + 8], 1
    je      return1

    ;else
    dec     [ebp + 8]               ;n-1
    push    [ebp + 8]
    call    fact

    ;prologue
    mov     esp, ebp
    pop     ebp
    pop     ecx

    ;#show [ebp + 8]

    imul    eax, [ebp + 8]          ;eax = n * fact(n - 1)

    ret

return1:
    mov     eax, 4                  ;return 1

    jle return1

    ;prologue
    mov     esp, ebp
    pop     ebp
    pop     ecx
    
    ret
    

main:
    push    4
    call    fact
    pop     ecx

    #show eax hex

    ret

;#exec "Programs/x86/recursiveFactorial.asm"