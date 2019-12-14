[org 0x7c00]

mov ah, 0x13; write string
mov al, 1 ;update cursor
mov bh, 0;bh page number
mov bl, 0x0c ; red color
mov cx, length
mov dl, 20 ;dl column number
mov dh, 10 ;dh row number
push cs 
pop es 
mov bp, string ;bp points to string
int 0x10

string: db 'Hello this is Bogdan bOS', 0
length: equ $ - string
times 510-($-$$) db 0
dw 0xaa55