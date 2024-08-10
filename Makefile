CROSS_COMPILE =arm-none-eabi-
CC		= $(CROSS_COMPILE)gcc
LD		= $(CROSS_COMPILE)ld
AR		= $(CROSS_COMPILE)ar
AS		= $(CROSS_COMPILE)as
OC		= $(CROSS_COMPILE)objcopy
OD		= $(CROSS_COMPILE)objdump
SZ		= $(CROSS_COMPILE)size

TARGET= main
SRCS= ./main.c ./startup.c
OBJS=$(SRCS:.c=.o)
CFLAGS	= 	-c -fno-common \
			-ffunction-sections \
			-fdata-sections \
			-g3 \
			-mcpu=cortex-m3 \
			-mthumb \
			-Wall
# removed optimization from CFLAGS -Os
# just testing Linode server
# testing pipeline job

LDSCRIPT= stm32f103.ld

LDFLAGS	=	--gc-sections,-T$(LDSCRIPT),-nostdlib

OCFLAGS	=	-Obinary

ODFLAGS	=	-S


.PHONY : clean all flash_st #flash_ocd


all: $(TARGET).bin  $(TARGET).list
	@echo "  SIZE $(TARGET).elf"
	$(SZ) $(TARGET).elf

$(TARGET).list: $(TARGET).elf
	@echo "  OBJDUMP $(TARGET).list"
	$(OD) $(ODFLAGS) $< > $(TARGET).lst



$(TARGET).bin: $(TARGET).elf
	@echo "  OBJCOPY $(TARGET).bin"
	$(OC) $(OCFLAGS) $(TARGET).elf $(TARGET).bin


main.elf: main.o startup.o
	$(CC) -mcpu=cortex-m3 -mthumb -nostartfiles -Wl,$(LDFLAGS),-o$(TARGET).elf,-Map,$(TARGET).map $(OBJS)


%.o: %.c
	@echo "  CC $<"
	$(CC) $(CFLAGS)  $< -o $*.o

clean:
	@echo "Removing files..."
	-find . -name '*.o'   | xargs rm 2>/dev/null || true
	-find . -name '*.elf' | xargs rm 2>/dev/null || true
	-find . -name '*.lst' | xargs rm 2>/dev/null || true
	-find . -name '*.out' | xargs rm 2>/dev/null || true
	-find . -name '*.bin' | xargs rm 2>/dev/null || true
	-find . -name '*.map' | xargs rm 2>/dev/null || true

flash_st:
	@echo "  Flashing firmware $(TARGET).bin to chip at address 0x8000000"
	st-flash write $(TARGET).bin 0x8000000
