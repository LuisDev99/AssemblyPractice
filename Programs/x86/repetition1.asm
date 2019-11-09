#import "libc.so.6":libc
call main
#stop

;void reverseArray(int arr[], int start, int end)
;{
;    while (start < end)
;    {
;        int temp = arr[start];
;        arr[start] = arr[end];
;        arr[end] = temp;
;        start++;
;        end--;
;    }
;}


printArray:
    #show eax
    mov ebx, 0                      ;i= 0
    mov ecx, [esp + 8]              ;size

for:
    cmp ecx, ebx
    jle after_for

    #set byte [0x10000018] = ["Print = %d ", 10, 0]
    mov eax, [esp + 4]
    mov eax, [eax + ebx * 4]

    push eax                        ;arr[i] argument of printf
    push 0x10000018                 ;literal "%d" argument of printf
    call @libc.printf:"p,si32"      ;printf("%d ", arr[i])
    ;pop edi                         
    ;pop edi
    add esp, 8

    inc  ebx
    jmp for
    

after_for:
    ;#set byte [0x10000018] = ["Finished", 10, 0]
    ;push 0x10000018
    ;call @libc.printf:"p"
    ;add esp, 4
    ;#show eax
    ret

reverseArray:
    push    ebp
    mov     ebp, esp

    mov     ebx, [ebp + 12]         ;start
    mov     ecx, [ebp + 16]         ;end
    cmp     ebx, ecx                ;start with end

while:
    je      end_of_reverse
    mov     eax, [ebp + 8]          ;&array
    mov     esi, [eax + ebx * 4]    ;temp = arr[start]
    mov     edx, [eax + ecx * 4]    ;edx = arr[end]

    mov     [eax + ebx * 4], edx    ;arr[start] = arr[end];
    mov     [eax + ecx * 4], esi    ;arr[end] = temp;

    inc     ebx
    dec     ecx
    jmp     while


end_of_reverse:
    leave
    ret

main:
    push    ebp
    mov     ebp, esp

    sub     esp, 20

    mov     [ebp - 20], 5
    mov     [ebp - 16], 4
    mov     [ebp - 12], 3
    mov     [ebp - 8], 2
    mov     [ebp - 4], 1

    push 5
    push 0
    lea     eax, [ebp - 20]
    push eax

    call reverseArray

    add     esp, 12

    #show eax

    push 5
    lea     eax, [ebp - 20]
    push eax

    call printArray

    ret

;#exec "Programs/x86/repetition1.asm"