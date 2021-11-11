print_hex:
    pusha

    mov cx, 0 ; out index variable

; Strategy: get the last character of 'dx', then convert to ASCII
; Numeric ASCII 0-9 is 0x30-0x39
; Alphabetic ASCII A-F is 0x41-0x46
; Then, move the ASCII byte to the correct position on the resulting string
hex_loop:
    cmp cx, 4
    je end

    ; 1. convert last char of 'dx' to ASCII
    mov ax, dx ; ax is our working register
    and ax, 0x000f ; mask the first three zeros
    add al, 0x30 ; convert it to the 0-9
    cmp al, 0x39 ; compare to 0x39 ('9' in ASCII)
    jle step2 ; if so continue to step2, otherwise go to next line then fall through to step2
    add al, 7 ; 'A' is 65 in ASCII, '9' is 58, so 65-58 is 7

step2:
    ; 2. get the correct position of the string to place our ASCII character
    ; bx <- base address + string length - index of character
    mov bx, HEX_OUT + 5 ; base address + length of our finished string
    sub bx, cx ; subtract our current index
    mov [bx], al ; copy the ASCII character on al to the position pointed by bx
    ror dx, 4 ; ror = rotate right, shift right by 4, 
              ; each hex number is 4 bits, so we're moving the 2nd
              ; digit from the left to the right by one, making it the least significant

    ; increment the index and loop
    add cx, 1
    jmp hex_loop

end:
    ; prepare the parameter and call the function
    ; remember that print receives parameters in 'bx'
    mov bx, HEX_OUT
    call print

    popa
    ret

HEX_OUT:
    db '0x0000', 0 ; reserve memory for our new string

