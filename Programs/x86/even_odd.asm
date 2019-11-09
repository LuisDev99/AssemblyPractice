#import "libc.so.6":libc
#set byte [0x10000000] = ["iseven(45) %d, iseven(44) %d", 10, 0]   ;Set the memory address of the string that printf will print out
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
    mov eax, [esp + 4]    ; get the paremeter that is in the stack and move it into a register, in this case, eax
                          
    and eax, 1            ; n & 1 
    cmp eax, 0            ; n & 1 == 0
    sete al               ; set the return value into eax register (eax -> lower 16 bits [ah, al] )
    ret

main:
    push 44               ; push first parameter
    call iseven
    add esp, 4            ; since we did one push before calling the function, we now have to balance the stack by adding 4 bytes to the stack pointer

    push eax              ; we want to save the value that the function returned IN THE STACK soo that later on we can use that value to print it out. The returned value is in the register eax (by agreement, por convenio)


    push 45
    call iseven
    add esp, 4

    push eax


    push 0x10000000
    call @libc.printf:"p,si32,si32"             ;printf(str, iseven(43), iseven(45))
    add esp, 12                                 ;add 12 to the stack pointer because we made three pushes without balancing (push eax was one, push eax was the other, push 0x1000000 was the last one)


    mov eax, 0             ; return 0
    ret 

;#exec "Programs/x86/even_odd.asm"



