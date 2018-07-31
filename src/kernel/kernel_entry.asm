; Ensures that our kernel always starts with main
[bits 32]
[extern main]	; Implies that there must be an external label named main
call main		; Call main() in our compiled kernel
jmp $			; Loop