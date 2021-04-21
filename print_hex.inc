;;
;; Print hexideximal using print.inc.
;; It (print.inc) must be included before this file.
;;

%macro print_hex 1
	push %1
	call _print_hex
	add sp, 0x02
%endmacro

_print_hex:
	push bp
	mov bp, sp
	mov cl, 0x00
	mov di, string
.lo	mov ax, [bp+4]
	shr ax, cl
	and al, 0x0f		;get low 4 bytes
	cmp al, 0x09
	jg .great		;if greater 0x09
	add al, 0x30		;then number ASCII
	jmp .next		;else
.great:	add al, 0x57		;letter ASCII
	
.next	mov [di+0x05], al	;move to variable string
	add cl, 0x04
	sub di, 0x01
	cmp cl, 0x0c
	jg .print
	jmp .lo

.print	mov ax, string
	print ax

	pop bp
	ret

string	db	"0x0000", 0x0a, 0x0d, 0
