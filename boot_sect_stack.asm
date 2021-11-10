mov ah, 0x0e ; tty mode

mov bp, [stack_start] ; base pointer to address thats far away from 0x7c00 (boot sect start)
mov sp, bp ; stack pointer to base pointer

push 'A'
push 'B'
push 'C'

; to show how stack grows downwards
mov al, [0x7ffe]
int 0x10

; don't try to access stack_start now, because it won't work
; you can only access the stack top so, at this point, only stack_start - 2 will work
mov al, [stack_start]
int 0x10

; pop our characters out
; you can only stack full words so we need an auxilitary register to manipulate
pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

; data that has been pop'd from the stack is garbage now
mov al, [stack_start]
int 0x10

jmp $

stack_start:
    dw 0x8000

times 510-($-$$) db 0
dw 0xaa55