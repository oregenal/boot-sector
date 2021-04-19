; Procedure print 
; input string pointer via stack frame
; output void
;
%macro print 1
	push %1
	call _print
	add sp, 0x02
%endmacro

_print:	push bp
	mov bp, sp
	push si
	mov ah, 0x0E
	mov si, [bp+4]		;geting string pointer
	xor bh, bh		;page number
.lo:	cmp es:[si], byte 0	;checking terminator end of line
	je .exit		;exit if so
	mov al, es:[si]		;print character by BIOS
	int 0x10
	inc si			;next character
	jmp .lo

.exit:	pop si
	pop bp
	ret
