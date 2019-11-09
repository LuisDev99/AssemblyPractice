call main
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

exp_r:
;#show [esp + 8]
    cmp     [esp + 8], 0
    je      return_exp_r
    
    mov     ebx, [esp + 4]      ;base
    mov     eax, [esp + 12]     ;exp
    imul    ebx
;    #show eax
    push    eax                 ;res*base

    dec     [esp + 8]
    #show [esp + 8] signed decimal
    push    [esp + 8]           ;exp - 1

    ;CODIGO VIEJO; ESTOY USANDO UN OFFSET QUE NO ExiSTE; EL Esp + 4 cuando hice un push; entonces seria esp + 8 porque hice un push
    ;push    [esp + 4]

    call    exp_r

    add     esp, 12

    ret


return_exp_r:
#show ecx
    mov     eax, [esp + 12]     ;return res
    ret

exp:
    mov     eax, [esp + 4]
    push    eax                 ;base
    mov     ebx, [esp + 12]
    sub     ebx, 1              ;exp - 1
    push    ebx
    push    eax                 ;base
    call    exp_r
    add     esp, 12             ;restore
    ret

main:
    push    3
    push    2
    call    exp
    add     esp, 8
    #show eax
    ret

;#exec "Programs/x86/recursiveExponent.asm"