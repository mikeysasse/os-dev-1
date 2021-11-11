[org 0x7c00] ; tell the assembler that our offset is bootsector code

; The main routine makes sure the parameters are ready and then calls the function
mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

mov dx, 0x12fe
call print_hex

jmp $

; remember to include files
%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"

HELLO:
    db "Hello, World!", 0

GOODBYE:
    db "Goodbye, cruel world. I'm leaving you today. Goodbye, goodbye.. goodbye.", 0

times 510-($-$$) db 0
dw 0xaa55