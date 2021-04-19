; Kernel

	;print character
	mov ah, 0x0E
	mov al, '!'
	int 0x10

	jmp start

%include "print.inc"

	;Print string.
	;input - string pointer
	;output - void
start:	mov ax, string1
	print ax
	mov ax, string2
	print ax
	mov ax, string3
	print ax

	mov ax, string4
	push ax
	call prt_str
	add sp, 0x02

	HLT		;halts CPU untill reset
	;jmp $

%include "print_string.inc"


string1	db	"Kernel loaded.", 0x0A, 0x0D, 0
string2	db	"AUGHTUNG!!! AUGHTUNG!!!", 0x0A, 0x0D, 0
string3	db	"Pokryshkin in der luft!", 0x0A, 0x0D, 0
string4 db	"Hello from BOIS print string!", 0

	times 512-($-$$) db 0
