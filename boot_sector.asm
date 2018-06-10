;
; A boot sector that prints a message to the screen using a BIOS routine:
;

mov ah, 0x0e	; Scrolling teletype interrupt (tty mode): 
				; prints al to screen

mov al, 'H'	; Load each character into al
int 0x10	; Call the interrupt
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
int 0x10
mov al, 'o'
int 0x10

jmp $	; Jump to the current address (Infinite loop)

times 510-($-$$) db 0	; Fill 510 minus size of previous
						; code 0's for padding

dw 0xaa55	; Magic number that helps the 
			; bios find end of boot sector
