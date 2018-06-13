;
; A boot sector that prints a message to the screen using a BIOS routine:
;

[org 0x7c00]				; Tell the assembler that memory addresses start at 0x7c00 (After BIOS memory)

	mov bx, WELCOME_MESSAGE
	call print_string

	mov bx, GOODBYE_MESSAGE
	call print_string

	mov dx, 0x1bf6
	call print_hex

	jmp $					; Jump to the current address (Infinite loop)

%include "print_string.asm"
%include "print_hex.asm"

; Data
WELCOME_MESSAGE:
	db 'Booting Charl-OS...',0

GOODBYE_MESSAGE:
	db 'Goodbye...',0

	times 510-($-$$) db 0	; Fill 510 minus size of previous
							; code 0's for padding

	dw 0xaa55				; Magic number that helps the 
							; bios find end of boot sector
