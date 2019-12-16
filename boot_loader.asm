; simple bootloader thats prints strings using interrupts

[org 0x7c00]

mov ax, 0x0003 ; set video mode to text mode 80x25 and clear screen
int 0x10

; call print from the other file
mov si, HELLO_MSG
call print_string

mov si, GOODBYE_MSG
call print_string

; infinite loop
jmp $

%include "print_string.asm"

; Data
HELLO_MSG: db "Hello, this is Bogdan bOS",13,10,0
GOODBYE_MSG: db "Goodbye !",13,10,0

; Padding
times 510-($-$$) db 0
; Magic number
dw 0xaa55