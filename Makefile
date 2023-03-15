.PHONY:run clean

run:disk.img
	qemu-system-x86_64 -vga virtio -full-screen -enable-kvm -cpu 486 -drive format=raw,if=floppy,file=$<

%.bin:%.asm
	nasm -fbin -llisting.txt $< -o $@

disk.img:loader.bin kernel.bin
	cat $^ > $@

clean:
	rm -rf *.bin disk.img listing.txt
