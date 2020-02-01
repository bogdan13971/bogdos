GDT_START:

NULL_SEGMENT_DESCRIPTOR:
dd 0x0
dd 0x0

CODE_SEGMENT_DESCRIPTOR:
dw 0xffff ;segment limit 15:00
dw 0x0000 ;segment base adress 15:00
db 0x00   ;segment base adress 23:16
db 10011010b ;1st flags, type flags
db 11001111b ;2nd flags, segment limit 19:16
db 0x00 ;segment base adress 31:24

DATA_SEGMENT_DESCRIPTOR:
dw 0xffff ;segment limit 15:00
dw 0x0000 ;segment base adress 15:00
db 0x00   ;segment base adress 23:16
db 10010010b ;1st flags, type flags
db 11001111b ;2nd flags, segment limit 19:16
db 0x00 ;segment base adress 31:24

GDT_END:

GDT_DESCRIPTOR:
dw GDT_END - GDT_START -1
dd GDT_START

CODE_SEG equ CODE_SEGMENT_DESCRIPTOR - GDT_START
DATA_SEG equ DATA_SEGMENT_DESCRIPTOR - GDT_START