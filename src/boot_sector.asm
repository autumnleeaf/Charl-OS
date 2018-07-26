;
; A boot sector that prints a message to the screen using a BIOS routine:
;

[org 0x7c00]				; Tell the assembler that memory addresses start at 0x7c00 (After BIOS memory)
KERNEL_OFFSET equ 0x1000	; The offset where we will store the kernel

	mov [BOOT_DRIVE], dl	; Store the location of the boot drive

	mov bp, 0x9000			; Move the stack to a safe location
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_string
	call print_nl

	call load_kernel		; Load the kernel

	call switch_to_pm

	jmp $					; Jump to the current address (Infinite loop)

%include "print/print_string.asm"
%include "print/print_hex.asm"
%include "print/print_string_pm.asm"
%include "pm_switch.asm"
%include "gdt.asm"
%include "disk_load.asm"

[bits 16]

load_kernel:
	mov bx, MSG_LOAD_KERNEL	; Print the loading kernel message
	call print_string
	call print_nl

	mov bx, KERNEL_OFFSET	; Set up parameters for disk load to help load the kernel
	mov dh, 15
	mov dl, [BOOT_DRIVE]
	call disk_load

	ret

[bits 32]
BEGIN_PM:					; Jump here after switch
	mov ebx, MSG_PROT_MODE
	call print_string_pm

	call KERNEL_OFFSET		; Jump to the address of the loaded kernel

	jmp $

BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit real mode",0
MSG_PROT_MODE db "Loaded 32-bit protected mode",0
MSG_LOAD_KERNEL db "Loading kernel into memory",0

	times 510-($-$$) db 0	; Fill 510 minus size of previous
							; code 0's for padding

	dw 0xaa55				; Magic number that helps the 
							; bios find end of boot sector

; boot sector = sector 1 of cyl 0 of head 0 of hdd 0
; from now on = sector 2 ...
	times 256 dw 0xdada		; Sector 2 = 512 bytes
	times 256 dw 0xface		; Sector 3 = 512 bytes