#import "libc.so.6":libc
call main
#stop

;int isprime(int n)
;{
;    int i, flag = 0;
;
;    for (i = 2; i <= n / 2; ++i)
;    {
;        if (n % i == 0)
;        {
;            flag = 1;
;            break;
;        }
;    }
;
;    return (flag == 0);
;}
;
;int main()
;{
;    printf("%d %d %d\n", isprime(3), isprime(7), isprime(13));
;}

isprime:
    ;epilogue
    push ebp
    mov ebp, esp

    push eax                    ;make room for i
    mov eax, 0
    push eax                    ;flag = 0 in stack

    mov [ebp - 4], 2            ;i = 2

for:
    mov eax, [ebp + 8]          ;move n into eax to compare

    ;n / 2                      ;eax = dividend; ecx = divisor
    mov ecx, 2
    cdq
    idiv ecx                    ;eax = eax / ecx

    cmp [ebp - 4], eax          ;n with i

    jg end_of_for               ;if n is greater than i, then stop

    mov eax, [ebp + 8]          ;move n into eax
    cdq
    idiv [ebp - 4]              ;n / i, but when want the modulus

    cmp edx, 0                  ;check if remainder is equal to zero

    jne next_iteration

    mov [ebp - 8], 1            ;flag = 1
    jmp end_of_for              ;breaking out if loop


next_iteration:
    inc [ebp - 4]
    jmp for


end_of_for:
    cmp [ebp - 8], 0            ;flag == 0
    sete al                     ;if (flag == 0) al = 1; else al = 0;

    movzx eax, al               ;extend al to eax with zero extension

    ;prologue
    pop ecx                     ;pop flag
    pop ecx                     ;pop i

    mov esp, ebp
    pop ebp

    ret


main:
    ;isprime(13)
    push 14
    call isprime 
    add esp, 4                  ;since we push 14, we have to clean up that space, soo we just move up the stack pointer by 4
    push eax

    ;isprime(7)
    push 7
    call isprime 
    add esp, 4
    push eax

    ;isprime(3)
    push 3
    call isprime 
    add esp, 4
    push eax

    push 0x10000000

    #set byte [0x10000000] = ["3 = %d, 7 = %d, 14 = %d ", 10, 0]

    call @libc.printf:"p,si32,si32,si32"

    ret


;#exec "Programs/x86/isprime.asm"
    