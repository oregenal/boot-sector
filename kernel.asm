; Kernel

	;print character
	mov ah, 0x0E
	mov al, '!'
	int 0x10

	jmp start

%include "print.inc"
%include "print_hex.inc"

	;Print string.
	;input - string pointer
	;output - void
start:	mov ax, string1
	print ax
	mov ax, string2
	print ax
	mov ax, string3
	print ax

	print_hex es
	print_hex cs
	print_hex ds
	print_hex ss

	HLT		;halts CPU untill reset
	;jmp $


string1	db	"Kernel loaded.", 0x0A, 0x0D, 0
string2	db	"AUGHTUNG!!! AUGHTUNG!!!", 0x0A, 0x0D, 0
string3	db	"Pokryshkin in der luft!", 0x0A, 0x0D, 0

	times 512-($-$$) db 0
