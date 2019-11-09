#import "libc.so.6":libc
#set byte [0x10000000] = ["iseven(45) %d, iseven(44) %d", 10, 0]
call main
#stop

;int iseven(int n){
;
;    return (n & 1) == 0;
;
;}
;
;int main() {
;
;    printf("iseven(45) %d, iseven(44) %d", iseven(45), iseven(44))
;
;    return 0;
;
;}


iseven:
    mov eax, [esp + 4]    ; para referenciar al primer argumento
    and eax, 1
    cmp eax, 0
    sete al               ; setear el valor de retorno en el registro eax, pero como set recibe solo un registro de 8 bits, le pasamos al que es de eax
    ret

main:
    push 44
    call iseven
    add esp, 4

    push eax            ;guardar el ret


    push 45
    call iseven
    add esp, 4

    push eax


    push 0x10000000
    call @libc.printf:"p,si32,si32"             ;printf(str, iseven(43), iseven(45))
    add esp, 12                                 ;12 para restaurar el sp 


    mov eax, 0
    ret 

;#exec "Programs/x86/even_odd.asm"



