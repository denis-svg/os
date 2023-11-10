nabofrev.img: bootloader.bin
	dd if=/dev/zero of=nabofrev.img bs=1024 count=1440
	dd if=bootloader.bin of=nabofrev.img seek=0 count=1 conv=notrunc

bootloader.bin: bootloader.asm
	nasm -f bin bootloader.asm -o bootloader.bin

run: nabofrev.img
	qemu-system-x86_64 -drive format=raw,file=nabofrev.img 

.PHONY: clean

clean:
	rm *.bin nabofrev.img
