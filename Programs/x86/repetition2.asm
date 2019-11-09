#import "libc.so.6":libc
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
    mov ebx, [esp + 4]

    and ebx, 1

    cmp ebx, 0

    je  return1

    mov eax, 0
    jmp end

return1:
    mov eax, 1
    jmp end

end:
    ret


main:
    push 5
    call iseven
    add esp, 4

    push eax

    push 2
    call iseven
    add esp, 4

    push eax

    #show eax

    #set byte [0x10000000] = ["%d %d", 10, 0]

    push 0x10000000

    call @libc.printf:"p,si32,si32"

    
    add esp, 12

    ret