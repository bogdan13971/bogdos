mov ah, 0x0e ;teletype interrupt
mov al, 'H'
int 0x10 
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
mov al, 'o'
int 0x10
mov al, ' '
int 0x10

mov al, '!'
mov bh, 0
mov bl, 0011b
mov cx, 3
mov ah, 0x09
int 0x10; print pixel at cursor

loop:
    jmp loop ;infinte loop

times 510 - ($ - $$) db 0
dw 0xaa55