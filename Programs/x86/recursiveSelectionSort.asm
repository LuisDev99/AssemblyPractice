call main
#stop

;int get_min(int arreglo[], int n){
;
;    int min = arreglo[0];
;
;    for(int i = 1; i < n; i++){
;        if(arreglo[min] > arreglo[i]){
;            min = i;
;        }
;    }
;
;    return min;
;}
;
;
;void selection_sort(int arreglo[], int n){
;    if(n > 1){
;        int pos = get_min(arreglo, n);
;
;        if(pos != 0){
;            int temp = arreglo[0];
;            arreglo[0] = arreglo[pos];
;            arreglo[pos] = temp;
;        }
;
;        selection_sort(&arreglo[1], n - 1);
;    }
;}



;DOESNT WORK, FIND THE BUG! :D GOOD LUCK




get_min:
    ;epilogo
    push    ebp
    mov     ebp, esp

    mov     eax, 0                      ;int min = arreglo[0]; this should be int min = 0, which is what im doing

    mov     ebx, 1                      ;int i = 1

for:
    cmp     ebx, [ebp + 12]             ;i < n
    jge     return_min


    ;TODO
    mov     ecx, [ebp + 8]
    mov     edx, [ecx + eax * 4]

    cmp     [ecx + ebx * 4], edx
    jge     next_iteration

    mov     eax, ebx
    jmp     next_iteration


next_iteration:
    inc     ebx                         ;i++
    jmp     for

return_min:
    leave
    ret


selection_sort:

    ;epilogo
    push    ebp
    mov     ebp, esp
    
    ; if(n > 1)
    cmp     [ebp + 12], 1               ;jump if 1 is greater or equal to n
    je      end_of_sort

    ;pushing parameters
    push    [ebp + 12]
    push    [ebp + 8]
    call    get_min
    #show eax
    add     esp, 8                      ;cleaning

    ;if(pos != 0)
    cmp     eax, 0
    je      after_if

    ;TODO
    mov     ebx, [ebp + 8]
    mov     ecx, [ebx]              ;temp = arreglo[0]
    mov     edx, [ebx + eax * 4]        ;arreglo[pos]
    mov     [ebx], edx              ;arreglo[0] = arreglo[pos]
    mov     [ebx + eax * 4], ecx        ;arreglo[pos] = temp

    jmp     after_if

after_if:
    dec     [ebp + 12]                  ;n - 1
    push    [ebp + 12]

    ;&arreglo[1]
    lea     eax, [ebp + 8]
    add     eax, 4

    push    eax

    call    selection_sort
    add     esp, 8


end_of_sort:
    leave
    ret


main:
    
    push    ebp
    mov     ebp, esp
    sub     esp, 24         ;Because its a local variable

    mov [ebp - 24], 3
    mov [ebp - 20], 20
    mov [ebp - 16], 11
    mov [ebp - 12], 4
    mov [ebp - 8], 44
    mov [ebp - 4], 6

    push    6

    lea     eax, [ebp - 24]
    push    eax

    call    selection_sort

    #show [ebp - 24] [6]

    leave

    ret


;#exec "Programs/x86/recursiveSelectionSort.asm"