; Kernel

CPU 8086

;; Global variables

STR_BUFFER	equ	0xb800

	;set segment registers
	mov ax, cs
	mov ds, ax
	mov ss, ax
	mov es, ax

	jmp start

%include "print.inc"
%include "print_hex.inc"

start:	mov ax, string1
	print ax

	print_hex es
	print_hex cs
	print_hex ds
	print_hex ss

	;output in video buffer
	push es
	push di
	push cx
	mov ax, STR_BUFFER
	mov es, ax
	mov cx, 0x07d0
	mov di, 0x0000	;shift
.loop:	mov es:[di], word 0100011101011010b
	add di, 0x02
	loop .loop
	pop cx
	pop di
	pop es

	;HLT		;halts CPU untill reset
	jmp $

string1	db	"Kernel loaded.", 0x0A, 0x0D, 0

	times 512-($-$$) db 0
