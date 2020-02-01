; Boot sector that boots a kernel in 32-bit protected mode
; based on the memory flat model
; 2 overlapping segments (code and data)
; spanned on all 4GB of memory

[bits 16] ; boot sector starts in 16 bits 
[org 0x7c00] ; boot sector is loaded by BIOS at this address
                ; all data will be offseted with this 

KERNEL_OFFSET equ 0x1000 ; load kernel in memory at this address 

mov ax, 0x0003 ; set video mode to text mode 80x25 and clear screen
int 0x10

mov [BOOT_DRIVE], dl ; BIOS stores current boot drive in 

mov bp, 0x9000 ; set stack address; stack grows to lower addresses
mov sp, bp

mov si, LOG_16MODE
call print_string

call load_kernel

mov si, LOG_SWITCH
call print_string

call switch_to_pm ; switch to protected mode

jmp $ ; hang here if ever returned from protected mode

; Include routines
%include "print/print_string.asm"
%include "disk/disk_load.asm"
%include "pm/gdt.asm"
%include "pm/print_string_pm.asm"
%include "pm/switch_to_pm.asm"

[bits 16]

load_kernel:
    mov si, LOG_KERNEL
    call print_string

    mov bx, KERNEL_OFFSET ; load kernel from boot disk to memory
    mov dh, 15 ; read the first 15 sectors excluding the first
    mov dl, [BOOT_DRIVE]
    call disk_load

    ret

[bits 32] ; code below starts in protected mode 

BEGIN_PM:
    mov esi, LOG_32MODE
    call print_string_pm

    call KERNEL_OFFSET ; jump to the adress of kernel code 
                        ; and start executing it

    jmp $ ; hang here if ever returned from kernel


; Global variables
BOOT_DRIVE : db 0
LOG_16MODE : db "Started in 16-bit Real Mode ",13,10,0
LOG_KERNEL : db "Loading kernel from drive ",13,10,0
LOG_SWITCH : db "Switching to Protected Mode ",13,10,0
LOG_32MODE : db "Landed in 32-bit Protected Mode ",0

times 510-($-$$) db 0 ; zero padding
dw 0xaa55 ; magic number