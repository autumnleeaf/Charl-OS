# Compiler and Linker
CC = gcc
LD = ld

# Flags for compiling c code
CFLAGS = -ffreestanding -c

# The emulator we will be using
EMU = qemu-system-x86_64

# Flags for running the emulator
EMUFLAGS = -fda

# The assembler and disassembler we will use
ASM = nasm
DISASM = ndisasm

# Assembler to object flags
AOFLAGS = -f elf

# Assembler to bin flags
ABFLAGS = -f bin

# Flags for disassembly
DFLAGS = -b 32

# Directories where files will be located
SRC = src
BUILD = build

KERNEL_DIR = $(SRC)/kernel
BOOT_DIR = $(SRC)/boot
DRIVERS_DIR = $(SRC)/drivers

# Automatically find all c sauces and headers
C_SAUCES = $(wildcard $(KERNEL_DIR)/*.c $(DRIVERS_DIR)/*.c)
HEADERS = $(wildcard $(KERNEL_DIR)/*.h $(DRIVERS_DIR)/*.h)

# Object files will be created in the build directory
OBJ = $(patsubst %.c,$(BUILD)%.o,$(C_SAUCES))

# Default make target
all: charl-os

# Aliases to make (pun intended) life easier
disasm: kernel.dis
kernel: kernel.bin

# Build the os and run using the emulator
run: all
	$(EMU) $(EMUFLAGS) charl-os

# Generic rules for c files
$(BUILD)/%.o : %.c ${HEADERS}
	$(CC) $(CFLAGS) $< -o $@

# Generic build rules for assembly to object files
$(BUILD)/%.o : %.asm
	$(ASM) $(AOFLAGS) $< -o $@

# Generic build rules for assembly to binary files
$(BUILD)/%.bin : %.asm
	$(ASM) $(ABFLAGS) $< -o $@

# Build the os image
charl-os: boot_sector.bin kernel.bin
	cat $^ > $@

# Build the kernel binary
kernel.bin: kernel_entry.o kernel.o
	$(LD) -o kernel.bin -Ttext 0x100 $^ --oformat binary

# Disassemble our kernel for debugging
kernel.dis: kernel.bin
	$(DISASM) $(DFLAGS) $< > $@

# Clear all generated files
clean:
	rm -rf $(BUILD) *.dis charl-os *.map