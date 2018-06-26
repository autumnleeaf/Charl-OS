%ifndef PM_SWITCH_ASM
%define PM_SWITCH_ASM

;
; Switch to 32-bit protected mode
;

[bits 16]
switch_to_pm:
	cli						; Turn off interrupts util we have 
							; set-up the protected mode interrupt vector

	lgdt [gdt_descriptor]	; Load gdt, which defines the protected mode segments

	mov eax, cr0			; Set the first bit of cr0 to 1 to enable
	or eax, 0x1				; protected mode
	mov cr0, eax

	jmp CODE_SEG:init_pm	; Make a far jump to 32 bit and flush
							; cache (so instructions don't mix)

[bits 32]
; Initialize registers and the stack once in PM
init_pm:
	mov ax, DATA_SEG		; Point segment registers to the data segment
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000		; Update stack to the top of the free space
	mov esp, ebp

	call BEGIN_PM			; Call some well known label

%include "gdt.asm"

%endif