; Boot sector.
;

BITS 16

LOAD_ADDRES	equ 0x7f00	;kernel loading addres


segment _boot
	;org 0x7c00

	; Setup segment registers
	mov ax, cs
	mov ds, ax
	mov ss, ax
	mov es, ax

	jmp start

%include "print.inc"
%include "print_hex.inc"

	; Set video mode
start:	mov ah, 0x00
	mov al, 0x03	;80x25x16 color text mode
	int 0x10

	; Set color pallete.
	mov ah, 0x0B
	mov bh, 0x00
	mov bl, 0x00
	int 0x10

	; Loader wellcome message
	mov ax, wellcome
	print ax

	; Graphic memory
	push es
	mov ax, 0xB800
	mov es, ax
	mov bx, 0x0F9E
	mov es:[bx], byte 'Z'
	pop es

	; Press any key
	mov ax, press_key
	print ax

	; Wait key pres.
	mov ah, 0x00
	int 0x16

	; Read next sector
	mov ah, 0x02
	mov al, 1	;number of sector to read
	push ax
	mov ch, 0	;track cylinder number
	mov cl, 2	;sector number
	mov dh, 0	;head number
	mov dl, 0	;drive number
	xor bx, bx	;buffer pointer EX:BX
	mov es, bx
	mov bx, LOAD_ADDRES	;offset
	int 0x13

	jc error	;if reading error, 'CF flag set'
	pop cx		;restore number to read
	cmp al, cl	;if it match with number of readed
	jne error

	;jump in kernel
	mov ax, LOAD_ADDRES
	shr ax, 1
	shr ax, 1
	shr ax, 1
	shr ax, 1
	push ax		;segment value
	xor ax, ax
	push ax		;offset value
	retf		;jump far segment:offset

	;read error
error:	mov ax, err_msg
	print ax

	hlt


err_msg		db	"Disk reading error!", 0x0A, 0x0D ,0
wellcome	db	"Bootsector loaded.", 0x0A, 0x0D ,0
press_key	db	"Press any key for load kernel.", 0x0a, 0x0d 0

segment _bootmag
	; Bootsector magic
	dw 0xaa55	;BIOS magic number for boot sector
