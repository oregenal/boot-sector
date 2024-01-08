/* Looks like is't commented */

/* ENTRY(start) */

MEMORY
{
	/* name(attr):ORIGIN=origin, LENGTH=len
	attr is
	r - read-only
	w - write & read
	x - executable code
	a - allocated sections
	i - initnalized sections
	l - same as i
	! - invert sense of any of the following attributes */

	BOOT(rx):ORIGIN =0x0, LENGTH =510
	BOOTMAGIC(rx):ORIGIN =0x01fe, LENGTH =2
	KERNEL(rx):ORIGIN =0x0200, LENGTH =1024
}

SECTIONS
{
	/*
	.text
	{
		*(.isr.vector)
		*(.text)
		*(.rodata)
		*(.data)
	}> (vma) AT> (lma)
	vma - virtual addres
	lma - load addres
	*/

	_boot :
	{
		*(_boot)
	}> BOOT

	_bootmag :
	{
		*(_bootmag)
	}> BOOTMAGIC

	_kernel :
	{
		*(_kernel)
	}> KERNEL

}
