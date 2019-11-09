mov eax, 100
cmp eax, 100

#show eflags        ;ZF = 1

cmp eax, 200

#show eflags        ;CF = 1, SF = 1   (CARRY FLAG ES EL OVERFLOW CON NUMEROS SIN SIGNO)

#show eax binary

#show al binary

mov ah, 0x88
mov al, -127

cmp al, 1           ; SF = 1

mov al, -127

cmp al, 2           ; OF = 1


#import "libc.so.6":libc
#set byte [0x10000000] = ["Hello World", 10, 0]     ; el 10 para el salto de linea, el 0 para caracter final
#show byte [0x10000000] [11] ascii

;para llamar a printF

push 0x10000000
call @libc.printf:"p"           ;signatures "p" pointer



;je o jz if zero