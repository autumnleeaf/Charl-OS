%ifndef PRINT_STRING_ASM
%define PRINT_STRING_ASM

;
; Prints the contents of a string stored at bx
;

; mov ah, 0x0e
; while(al != 0) {
;	mov al, [bx]
;	int 0x10
;	bx++
; }

print_string:
	pusha
	mov ah, 0x0e
print_string_loop:
	mov al, [bx]		; Load in the character at the offset
	cmp al, 0
	je print_string_end
	int 0x10			; Print the character
	add bx, 1			; Update the counter
	jmp print_string_loop
print_string_end:
	popa
	ret


; Print a newline character
print_nl:
	pusha

	mov ah, 0x0e
	mov al, 0x0a		; newline char
	int 0x10
	mov al, 0x0d		; carriage return
	int 0x10

	popa
	ret

%endif