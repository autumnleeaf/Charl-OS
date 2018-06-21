;
; Creates the Global Descriptor Table for our OS
;

%ifndef GDT_ASM
%define GDT_ASM

; Breakdown
;	Base: 0x0
;	Limit: 0xfffff
;	Present: 1 (segment is present in memory)
;	Privilige: 0 (highest privilige)
;	Descriptor Type: 1 for code/data, 0 for traps
;	Type:
;		Code: 1 for code
;		Conforming: 0 (Code in a lower priviliged 
;			segment may not call code in this segment)
;		Readable: 1 (0 if execute only)
;		Accessed: 0 (Used for debugging and virtual memory)
;	Other Flags:
;		Granularity: 1 (multiplies limit by 4k)
;		32-bit Default: 1 (Segment will hold 32-bit code)
;		64-bit Code Segment: 0 (Not used in 32-bit processors)
;		AVL: 0 (May be set for debugging)

; The data segment will change the following:
;	Code: 0
;	Expand Down: 0
;	Writable: 1
;	Accessed: 0

gdt_start:

gdt_null:			; Mandatory null descriptor (must start w/ 8 null bytes)
	dd 0x0			; Define a double (4 bytes)
	dd 0x0

gdt_code:			; The code segment
; First flags: (present) 1 (privilege) 00 (descriptor type) 1 -> 1001b
; Type flags: (code) 1 (conforming) 0 (readable) 1 (accessed) 0 -> 1010b
; 2nd flags: (granularity) 1 (32-bit default) 1 (64-bit seg) 0 (AVL) 0 -> 1100b
	dw 0xffff		; Limit (bits 0-15)
	dw 0x0			; Base (bits 0-15)
	db 0x0			; Base (bits 16-23)
	db 10011010b	; 1st flags and type flags
	db 11001111b	; 2nd flags, Limit (bits 16-19)
	db 0x0			; Base (bits 24-31)

gdt_data:
; Same as code segment except for the following flags
; type flags: (code) 0 (expand down) 0 (writable) 1 (accessed) 0 -> 0010b
	dw 0xffff		; Limit (bits 0-15)
	dw 0x0			; Base (bits 0-15)
	db 0x0			; Base (bits 16-23)
	db 10010010b	; 1st flags and type flags
	db 11001111b	; 2nd flags, Limit (bits 16-19)
	db 0x0			; Base (bits 24-31)

gdt_end:			; Used to help calculate the size of the GDT

; GDT descriptor
gdt_descriptor:
	dw gdt_end - gdt_start - 1	; GDT size is one less than actual size

	dd gdt_start				; Store the start of our GDT

; Constants that help us find the segment descriptor offsets
CODE_SEG: equ gdt_code - gdt_start
DATA_SEG: equ gdt_data - gdt_start

%endif