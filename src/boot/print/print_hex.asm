%ifndef PRINT_HEX_ASM
%define PRINT_HEX_ASM

;
; Print a hexadecimal value as a string for debugging
;

; bx = 0
; for(cx = 0; cx < 4; cx++) {
;	ax = [bx] and 0x000f
;	dx >> 4
;	if(ax > 10)
;		ax += 0xb
;	[HEX_OUT + bx] += ax
;	bx++
; }

print_hex:
	pusha
	mov cx, 0				; index

print_hex_loop:
	cmp cx, 4				; check if cx >= 4
	jge print_hex_end		; if so jump to the end

	mov ax, dx				; store the value from dx in ax
	and ax, 0x000f			; mask everything but the last 4 bits

	add al, 0x30			; increment by 0x30
	cmp al, 0x39
	jle print_hex_endif
	add al, 0x07			; if the value is greater than 0xa, add 0x11

print_hex_endif:
	mov bx, HEX_OUT + 5		; move pointer to appropriate place
	sub bx, cx

	mov [bx], al			; update value to print

	shr dx, 4				; shift dx by 4 for the next cycle

	add cx, 1				; index++
	jmp print_hex_loop		; jump

print_hex_end:
	mov bx, HEX_OUT			; print the string we built
	call print_string
	popa
	ret

HEX_OUT: db '0x0000',0	; Output of print_hex will be stored here

%include "print/print_string.asm"

%endif