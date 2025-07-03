# Makefile para Lab 3 - Parte 1 - sin usar libc ni startup

all: main.elf

main.elf: LAB3-P1.s
	riscv64-unknown-elf-gcc -nostartfiles -nostdlib -o main.elf LAB3-P1.s

clean:
	rm -f main.elf
