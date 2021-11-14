; load 'dh' sectors from drive 'dl' into ES:BX
disk_load:
    pusha
    ; reading from disk requires settings specific registers
    ; so we'll push our dx and pop it back later
    push dx

    mov ah, 0x02 ; ah <- int 0x13 function. 0x02 = 'read'
    mov al, dh ; number of sectors to read
    mov cl, 0x02 ; sector number, 0x01 is our boot sector so 0x02 is next available

    mov ch, 0x00 ; cylinder
    ; dl = drive number, caller sets it as a parameter
    ; 0=floppy, 1=floppy2, 0x80=hdd, 0x81=hdd2
    mov dh, 0x00 ; head number

    ; [es:bx] is pointer to the buffer where loaded data will be stored
    ; caller sets it for us, and it is actually the standard location for int 13h
    int 0x13 ; bios interrupt
    jc disk_error ; jump if carry bit is set

    pop dx
    cmp al, dh
    jne sectors_error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah = error code, dl = disk drive that dropped the error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0