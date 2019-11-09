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
;
;void printArray(int arr[], int size)
;{
;    for (int i = 0; i < size; i++)
;    {
;        printf("%d ", arr[i]);
;    }
;
;    printf("\n");
;}
;
;int main()
;{
;    int arr[] = {1, 2, 3, 4, 5, 6};
;
;    printArray(arr, 5);
;
;    reverseArray(arr, 0, 5);
;
;    printf("Reversed array is\n");
;
;    printArray(arr, 5);
;
;    return 0;
;}

printArray:
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
    ;epilogo
    ;push ebp
    ;mov ebp, esp

    mov eax, [esp + 8]              ;start
    mov ebx, [esp + 12]             ;end
    mov ecx, [esp + 4]              ;&arr

while:
    cmp ebx, eax                    ;jump if end is less or equal to start
    jle  end_of_reverse             ;


    mov edx, [ecx + eax * 4]        ;temp = arr[start]
    mov edi, [ecx + ebx * 4]        ;arr[end] 
    mov [ecx + eax * 4], edi        ;arr[start] = arr[end]
    mov [ecx + ebx * 4], edx        ;arr[end] = temp

    ;add [esp + 8], 1                ;start++
    ;sub [esp + 12], 1               ;end--
    inc eax
    dec ebx

    jmp while
    

end_of_reverse:
    ;prologue

    ret
    
main:
    push ebp
    mov ebp, esp
    sub     esp, 24         ;PORQUE ES VARIABLE LOCAL

    mov [ebp - 24], 1
    mov [ebp - 20], 2
    mov [ebp - 16], 3
    mov [ebp - 12], 4
    mov [ebp - 8], 5
    mov [ebp - 4], 6

    push 6
    lea eax, [ebp - 24]     ;PASAR LA DIRECCION EFECTIVA A EAX DE EBP
    push eax

    ;old
    ;push 0x10000000
    ;mov [0x10000000], 1
    ;mov [0x10000004], 2
    ;mov [0x10000008], 3
    ;mov [0x1000000c], 4
    ;mov [0x10000010], 5
    ;mov [0x10000014], 6

    call printArray
    #show eax
    add esp, 8                  ;reset stack pointer

    push 5
    push 0
    lea eax, [ebp - 24]     ;PASAR LA DIRECCION EFECTIVA A EAX DE EBP
    push eax
    call reverseArray

    add esp, 12                 ;reset

    #set byte [0x10000018] = ["Reversed array is ", 10, 0]
    push 0x10000018
    call @libc.printf:"p"

    add esp, 4

    push 6
    lea eax, [ebp - 24]     ;PASAR LA DIRECCION EFECTIVA A EAX DE EBP
    push eax
    call printArray 

    ret 

;#exec "Programs/x86/reverseArray.asm"