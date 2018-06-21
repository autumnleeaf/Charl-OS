;
; A boot sector that prints a message to the screen using a BIOS routine:
;

[org 0x7c00]				; Tell the assembler that memory addresses start at 0x7c00 (After BIOS memory)
	mov [BOOT_DRIVE], dl	; Save the location of out boot drive (default of dl)

	mov bp, 0x8000			; Move the stack to a safe location
	mov sp, bp

	mov bx, 0x9000			; Load to 0x0000(es):0x9000(bx)
	mov dh, 2				; Load 5 sectors
	mov dl, [BOOT_DRIVE]
	call disk_load

	mov dx, [0x9000]		; Test to see if memory at this location is 0xdada
	call print_hex
	call print_nl

	mov dx, [0x9000 + 512]	; Test to see if memory at this location is 0xface
	call print_hex
	call print_nl

	jmp $					; Jump to the current address (Infinite loop)

%include "print/print_string.asm"
%include "print/print_hex.asm"
%include "disk_load.asm"

; Data
BOOT_DRIVE:
	db 0

	times 510-($-$$) db 0	; Fill 510 minus size of previous
							; code 0's for padding

	dw 0xaa55				; Magic number that helps the 
							; bios find end of boot sector

; boot sector = sector 1 of cyl 0 of head 0 of hdd 0
; from now on = sector 2 ...
	times 256 dw 0xdada		; Sector 2 = 512 bytes
	times 256 dw 0xface		; Sector 3 = 512 bytes