;
; A boot sector that prints a message to the screen using a BIOS routine:
;

[org 0x7c00]				; Tell the assembler that memory addresses start at 0x7c00 (After BIOS memory)
	mov bp, 0x9000			; Move the stack to a safe location
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_string
	call print_nl

	call switch_to_pm

	jmp $					; Jump to the current address (Infinite loop)

%include "print/print_string.asm"
%include "print/print_hex.asm"
%include "print/print_string_pm.asm"
%include "pm_switch.asm"
%include "gdt.asm"

[bits 32]
BEGIN_PM:					; Jump here after switch
	mov ebx, MSG_PROT_MODE
	call print_string_pm
	jmp $

MSG_REAL_MODE db "Started in 16-bit real mode",0
MSG_PROT_MODE db "Loaded 32-bit protected mode",0

	times 510-($-$$) db 0	; Fill 510 minus size of previous
							; code 0's for padding

	dw 0xaa55				; Magic number that helps the 
							; bios find end of boot sector

; boot sector = sector 1 of cyl 0 of head 0 of hdd 0
; from now on = sector 2 ...
	times 256 dw 0xdada		; Sector 2 = 512 bytes
	times 256 dw 0xface		; Sector 3 = 512 bytes