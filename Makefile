bogdos.bin: boot_sector.bin kernel.bin
	cat boot_sector.bin kernel.bin > bogdos.bin
	cp bogdos.bin Bochs-2.6.10/

boot_sector.bin: boot_sector.asm 
	nasm -f bin boot_sector.asm -o boot_sector.bin 

kernel_stub.o: kernel_stub.asm
	nasm -f elf kernel_stub.asm -o kernel_stub.o

kernel_body.o: kernel.c
	gcc -ffreestanding -fno-pie -c kernel.c -o kernel_body.o -m32

kernel.bin: kernel_stub.o kernel_body.o
	ld -m elf_i386 -nostdlib -nostartfiles -nodefaultlibs -o kernel.o -Ttext 0x1000 kernel_stub.o kernel_body.o 
	objcopy -R.comment -R.eh_frame -O binary kernel.o kernel.bin  	

clean:
	rm -f *.o *.bin