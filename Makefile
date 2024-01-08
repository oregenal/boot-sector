ASM=nasm
ASMFLAGS=-felf32
LD=ld
LDFLAGS=-melf_i386 -nostdlib --oformat=binary -T config.ld -Map=$(MAPFILE)
OBJFILES=loader.o kernel.o

MAPFILE=disk.map
DISKFILE=disk.img

.PHONY:run clean

run:$(DISKFILE)
	qemu-system-x86_64 -vga virtio\
		-full-screen -enable-kvm -cpu 486\
		-drive format=raw,if=floppy,file=$<

%.o:%.asm
	$(ASM) $(ASMFLAGS) -o $@ $< 

disk.img:$(OBJFILES)
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	rm -rf *.o *.bin $(DISKFILE) $(MAPFILE)
