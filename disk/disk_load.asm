;es:bx pointer to memory to save to
;dh number of sectors to read
;dl drive number 
disk_load:
    pusha
    push dx
    mov ah, 0x02 ;ah read disk interrupt
    mov al, dh ; al read this many sectors
    mov ch, 0x00 ;ch cylinder number
    mov dh, 0x00 ;dh read head
    mov cl, 0x02 ;cl start reading from this sector
    int 0x13
    jc error_no_read ;check carry flag
    pop dx
    cmp dh, al ;check if all the requested sectors were read
    je end_disk_load
    jne error_partial_read
    error_no_read:
    mov si, error_no_sectors
    call print_string
    jmp $ ;hang here if error happened
    error_partial_read:
    mov si, error_not_all_sectors
    call print_string
    xor dx, dx
    mov dl, al
    call print_hex
    jmp $ ;hang here if error happened
    end_disk_load:
    popa 
    ret
    error_no_sectors: db "Error no sectors were read",13,10,0
    error_not_all_sectors: db "Error only read "
