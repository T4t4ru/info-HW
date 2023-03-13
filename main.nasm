section .data
    msg1 db "Процессор: ", 0
    msg2 db "Оперативная память: ", 0
    msg3 db "Информация о памяти: ", 0

section .text
    global _start

_start:
    ; Выводим информацию о процессоре
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, 11
    int 0x80

    mov eax, 0x80000002 ; Первый вызов функции CPUID для получения информации о процессоре
    xor ebx, ebx
    cpuid
    mov eax, ebx
    mov [cpu_info+0], eax
    mov eax, edx
    mov [cpu_info+4], eax
    mov eax, ecx
    mov [cpu_info+8], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, cpu_info
    mov edx, 12
    int 0x80

    ; Выводим информацию об оперативной памяти
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, 20
    int 0x80

    mov eax, 0x15 ; Вызов функции для получения размера оперативной памяти
    xor ebx, ebx
    int 0x80
    mov [mem_info+0], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, mem_info
    mov edx, 4
    int 0x80

    ; Выводим информацию о памяти
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, 18
    int 0x80

    mov eax, 0x48 ; Вызов функции для получения информации о памяти
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    int 0x80
    mov [mem_info+0], ebx
    mov [mem_info+4], ecx
    mov [mem_info+8], edx

    mov eax, 4
    mov ebx, 1
    mov ecx, mem_info
    mov edx, 12
    int 0x80

    ; Выходим из программы
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .bss
    cpu_info resb 12
    mem_info resd 3
