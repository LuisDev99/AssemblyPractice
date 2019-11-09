#import "libc.so.6":libc
call main
#stop

;---------------------------------------|
; void printArray(int *array, int n){   |
;     for(int i = 0; i < n; i++){       |
;         printf("%d\n", array[i]);     |
;     }                                 |
; }                                     |
;---------------------------------------|

;-------------------------------------------|  
; void BubbleSort(int *array, int n) {      |      
;   bool swapped = true;                    |
;   int j = 0;                              |
;   int temp;                               |                                   
;                                           |             
;   while (swapped) {                       |
;     swapped = false;                      |
;     j++;                                  |
;     for (int i = 0; i < n - j; ++i) {     |
;       if (array[i] > array[i + 1]) {      |
;         temp = array[i];                  |
;         array[i] = array[i + 1];          |
;         array[i + 1] = temp;              |
;         swapped = true;                   |
;       }                                   |
;     }                                     |
;   }                                       |
; }                                         |
;-------------------------------------------| 

printArray:
    mov     esi, 0                  ;i = 0

for_2:

    cmp     esi, [esp + 8]          ;i < n
    jge     end_of_print

    #set byte [0x1000001c] = ["Element = %d ", 10, 0]

    mov     ebx, [esp + 4]          ;&arr

    push    [ebx + esi * 4]         ;array[i]
    push    0x1000001c

    call @libc.printf:"p,si32"
    pop     ecx
    pop     ecx


    inc     esi
    jmp     for_2

end_of_print:
    ret

BubbleSort:
    ;epilogue
    push    ebp
    mov     ebp, esp

    mov     eax, 1                  ;swapped = true
    push    eax
    mov     eax, 0                  ;j=0
    push    eax
    push    eax                     ;temp = 0
    jmp     while

while:
    cmp     [ebp - 4], 0
    je      end_of_function         ;if(swapped == 0) exit

    mov     [ebp - 4], 0            ;swapped = false
    inc     [ebp - 8]               ;j++

    mov     eax, 0
    push    eax                     ;int i = 0

for:

    mov     ebx, [ebp - 8]          ;j
    mov     eax, [ebp + 12]         ;n
    sub     eax, ebx                ;eax = n - j

    cmp     [ebp - 16], eax         ;i < n - j
    jge     break_for_loop          ;if i is equal or greater, exit for loop

    mov     eax, [ebp - 16]         ;i
    mov     ebx, 1
    add     ebx, eax                ;i+1
    mov     ecx, [ebp + 8]          ;&array

    mov     edx, [ecx + eax * 4]    ;array[i]

    cmp     [ecx + ebx * 4], edx    ;array[i] > array[i + 1]

    jge     next_for_iteration

    mov     eax, [ebp - 16]         ;i
    mov     ebx, 1
    add     ebx, eax                ;i+1
    mov     ecx, [ebp + 8]          ;&array

    mov     edx, [ecx + eax * 4]    ;temp = array[i]

    mov     esi, [ecx + ebx * 4]    ;array[i + 1]
    mov     [ecx + eax * 4], esi    ;array[i] = array[i + 1]
    mov     [ecx + ebx * 4], edx

    mov     [ebp - 4], 1            ;swapped = true
    jmp     next_for_iteration


next_for_iteration:
    inc     [ebp - 16]              ;++i
    jmp     for

break_for_loop:
    pop     esi                     ;destroy i
    jmp     while

end_of_function:
    pop     ecx
    pop     ecx
    pop     ecx

    ;prologue
    mov     esp, ebp
    pop     ebp

    ret


main:
    ;Not the best way to pass an array as parameter, it should be through the stack! See other examples
    mov [0x10000000], 5
    mov [0x10000004], 10
    mov [0x10000008], 4
    mov [0x1000000c], 7
    mov [0x10000010], 1
    mov [0x10000014], 23
    mov [0x10000018], 55
    ;mov [0x1000001c], 8

    push 7
    push 0x10000000

    call BubbleSort

    ;#show [0x10000000] [7] 
    

    add esp, 8

    push 8
    push 0x10000000
    call printArray

    add esp, 8

    ret

;#exec "Programs/x86/bubbleSort.asm"