; ----------------------------------------------------------------------- ;
; Program:              x86 Controlled Input
; Version:              1.0
; Developer:            Kevin Thomas
; Creation Date:        02/16/17
; Update Date:          02/16/17
; Copyright:            Copyright: (c) 2020, Kevin Thomas <kevin@mytechnotalent.com>
; License:              Apache License, Version 2.0 (see COPYING or https://www.apache.org/licenses/LICENSE-2.0)
; Platform:             x86
; Compile:              nasm -f elf32 x86_controlled_input.asm
; Link:                 ld -m elf_i386 -o x86_controlled_input
;                       x86_controlled_input.o
; Description:          A program that takes a maximum of 4 bytes of
;                       input from the terminal and checks for a
;                       successful combination of 4 continous integers
;                       otherwise loops to obtain a fresh buffer of
;                       input and if 4 continous integers are obtained
;                       and there are additional characters inputted
;                       they get flushed from the buffer.
; ----------------------------------------------------------------------- ;


section .bss
    buffer      resb    4
    buffer_len  equ     $ - buffer
    fbuffer     resb    1
    fbuffer_len equ     $ - fbuffer       

section .data
    prompt      db      "Enter ONLY 4 Integers:", 0xa
    prompt_len  equ     $ - prompt
    result      db      "Result:  "
    result_len  equ     $ - result
    lr          db      0xa
    lr_len      equ     $ - lr

section .text
    global      _start

_start:
    mov         ecx, prompt
    mov         edx, prompt_len
    call        sys_write

    call        sys_read

    mov         ecx, buffer
    mov         edx, buffer_len
    call        sys_write

    mov         ecx, lr
    mov         edx, lr_len
    call        sys_write

    call        flush

    call        sys_exit        

sys_write:
    mov         eax, 4
    mov         ebx, 1
    int         0x80
    ret

sys_read:
    mov         ecx, buffer
    mov         edx, buffer_len
    mov         eax, 3
    mov         ebx, 0
    int         0x80
    mov         eax, buffer_len
    mov         ebx, buffer

test_loop:    
    cmp         byte [ebx], 0x30            ; cmp ascii '0'
    jb          sys_read                    ; jb if lower than '0'
    cmp         byte [ebx], 0x39            ; cmp ascii '9'
    ja          sys_read                    ; ja if higer than '9'
    inc         ebx
    dec         eax
    jne         test_loop
    ret

flush:
    mov         eax, 3
    mov         ebx, 0
    mov         ecx, fbuffer
    mov         edx, fbuffer_len
    int         0x80
    cmp         byte [ecx + edx - 1], 0xa   ; cmp line feed
    jne         flush
    ret

sys_exit:
    mov         eax, 1
    mov         ebx, 0
    int         0x80
