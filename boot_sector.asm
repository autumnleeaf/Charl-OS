; This will be the boot sector of my operating system:

; Welcome message:
mov ah, 0x0e ; tty mode
mov al, 'H'
int 0x10 ; Print the contents of the al register
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10

; Infinite loop:
jmp $

; Fill 510 minus size of previous code 0's
times 510-($-$$) db 0

; Helps the bios find end of boot sector
dw 0xaa55
