[bits 16]

;si address of string
print_string:
    pusha
    mov ah, 0x0e ;teletype output
    cld ;left direction
    print_char:
    lodsb ;load byte from DS:SI and increment SI
    cmp al ,0 ;compare with null terminator
    je end_print
    int 0x10
    jmp print_char
    end_print:
    popa
    ret

;dx number to print
print_hex:
    pusha
    mov cx, 4 ;repeat 4 times
    mov bx, hex_table ;load hex table
    mov di, hex_out+5 ;load hex format
    std ;iterate backwards
    print_hex_digit:
    mov ax, dx
    and ax, 0x000f ;isolate last byte
    xlat ;al = mapped from hex table
    stosb ;stored al to es:di
    shr dx, 4 ;divided number by 16
    loop print_hex_digit
    mov si, hex_out
    call print_string
    popa
    ret
    hex_table: db "0123456789ABCDEF"
    hex_out: db "0x0000",13,10,0