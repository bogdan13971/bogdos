; Kernel stub that jumps into the main function
; this should be linked to the kernel code
[bits 32]
[extern main]

call main ; linker should resolve this into the main of the c file
jmp $ ; hang here if returned from kernel