%ifndef PRINT_HEX_ASM
%define PRINT_HEX_ASM

;
; Print a hexadecimal value as a string for debugging
;

; bx = 0
; while(bx < 4) {
;	ax = [bx] and 0x000f
;	dx >> 4
;	if(ax > 10)
;		ax += 0xb
;	[HEX_OUT + bx] += ax
;	bx++
; }

print_hex:
	pusha
	mov bx, HEX_OUT
	add bx, 5
print_hex_loop:
	mov ax, HEX_OUT 	; we want to see if bx is at 
	add ax, 1			; HEX_OUT + 7 (end of string)
	cmp bx, ax			; otherwise jump out of the loop
	je print_hex_end
	mov ax, dx		; store the value from dx in ax
	and ax, 0x000f	; mask everything but the last 4 bits
	shr dx, 4		; shift dx by 4 for the next cycle
	cmp ax, 10
	jl print_hex_endif
	add ax, 11		; if the value is greater than 0xa, add 11
print_hex_endif:
	add [bx], ax ;
	sub bx, 1
	jmp print_hex_loop
print_hex_end:
	mov bx, HEX_OUT
	call print_string
	popa
	ret

HEX_OUT: db '0x0000',0	; Output of print_hex will be stored here

%include "print_string.asm"

%endif