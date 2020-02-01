[bits 16]

switch_to_pm:
    cli ;clear interrupts
    lgdt [GDT_DESCRIPTOR] ;load global descriptor table
    
    mov eax, cr0 ;set paging
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm ;jmp far to code segment

[bits 32]
; Initialize registers and stack of the protected mode
init_pm:
    mov eax, DATA_SEG
    mov ds, eax
    mov es, eax
    mov ss, eax
    mov fs, eax
    mov gs, eax

    mov ebp, 0x90000
    mov esp, ebp

    call BEGIN_PM