%ifndef DISK_LOAD_ASM
%define DISK_LOAD_ASM

;
; Load dh sectors to es:bx from drive dl
;

disk_load:
	push dx			; Push dx to the stack so we can check it later

	mov ah, 0x02	; Specifies the read sector function

	mov al, dh		; Read dh number of sectors
	mov ch, 0x00	; Select cylinder 0
	mov dh, 0x00	; Select disk 0
	mov cl, 0x02	; Start from the second sector (after boot sector)

	int 0x13		; Call the BIOS interrupt

	jc disk_error	; If the carry flag is set jump

	pop dx			; Restore dx from the stack
	cmp al, dh		; See if the number of sectors read == the number expected
	jne disk_error	; Otherwise print the error
	ret

disk_error:
	mov bx, DISK_ERROR_MSG
	call print_string
	jmp $



DISK_ERROR_MSG:
	db "Disk read error!",0

%include "print_string.asm"

%endif