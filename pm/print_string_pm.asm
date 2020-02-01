[bits 32]

;ds:esi pointer to string
print_string_pm:
    pusha
    mov edi, VIDEO_MEMORY
    print_char_pm:
    lodsb ;load byte from ds:esi into al, esi+=1 
    cmp al, 0 ;check for end of string
    je print_string_pm_end
    stosb ;save byte from al to es:edi, edi+=1
    inc edi ;edi+=1, skip the color byte
    jmp print_char_pm
    print_string_pm_end:
    popa
    ret
    ; print a few lines below the previous logs
    VIDEO_MEMORY: equ 0xb8000+2*4*80