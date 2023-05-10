.PHONY: all
all: raspi3

.PHONY: raspi3
raspi3: build/raspi3/kernel8.img

.PHONY: raspi3-emu-gdb
raspi3-emu-gdb: raspi3
	qemu-system-aarch64 -M raspi3b -kernel build/raspi3/kernel8.img -nographic -s -S

build/raspi3/kernel8.img: build/raspi3/boot.o asm/raspi3/kernel8.ld
	ld.lld -m aarch64elf -T asm/raspi3/kernel8.ld build/raspi3/boot.o -o build/raspi3/kernel8.elf
	objcopy build/raspi3/kernel8.elf -O binary build/raspi3/kernel8.img

build/raspi3/boot.o: build/raspi3 asm/raspi3/boot.S
	clang -target aarch64-none-elf -g -c asm/raspi3/boot.S -o build/raspi3/boot.o

build/raspi3:
	mkdir -p build/raspi3

clean:
	rm -rf build
