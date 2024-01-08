.PHONY:run clean

run:disk.img
	qemu-system-x86_64 -vga virtio -full-screen -enable-kvm -cpu 486 -drive format=raw,if=floppy,file=$<

%.o:%.asm
	nasm -felf32 $< -o $@

disk.img:loader.o kernel.o
	ld -melf_i386 -nostdlib --oformat=binary -T config.ld -o $@ $^

clean:
	rm -rf *.o *.bin disk.img listing.txt
