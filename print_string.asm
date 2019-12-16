;si addres of string
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
