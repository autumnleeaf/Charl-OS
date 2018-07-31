%ifndef PRINT_STRING_PM_ASM
%define PRINT_STRING_PM_ASM

;
; Prints the contents of a string pointed to by EBX (32-bit protected mode)
;

[bits 32]
; pome constants we will need
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f


print_string_pm:
	pusha
	mov edx, VIDEO_MEMORY

print_string_pm_loop:
	mov al, [ebx]		; load in the character at the offset
	mov ah, WHITE_ON_BLACK

	cmp al, 0
	je print_string_pm_end

	mov [edx], ax		; move the character into video memory

	add ebx, 1			; update the pointer
	add edx, 2			; move to the next character cell

	jmp print_string_pm_loop
print_string_pm_end:
	popa
	ret

%endif