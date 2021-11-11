mov al, 'X'
jmp print

endprint:


print:
    mov ah, 0x0e ; tty code
    int 0x10
    jmp endprint