# Put the filename of the output binary here
TARGET = libdreamroq.a

# List all of your C files here, but change the extension to ".o"
OBJS = dreamroq-player.o dreamroqlib.o
OBJS += libdcmc/timer.o

#AICA Audio Driver
KOS_CFLAGS += -I. -Ilibdcmc/
OBJS += libdcmc/roq_audio.o
OBJS += libdcmc/snddrv.o

all: rm-elf $(TARGET)

rm-elf:
	-rm -f $(TARGET)

clean:
	-rm -f $(TARGET) $(OBJS) output.bin

link:
	$(KOS_AR) rcs $(TARGET) $(OBJS)

build: $(OBJS) link

samples: build
	$(KOS_MAKE) -C samples all

defaultall: create_kos_link $(OBJS) subdirs linklib samples
	
include $(KOS_BASE)/Makefile.rules
include $(KOS_BASE)/addons/Makefile.prefab

create_kos_link:
	rm -f $(KOS_BASE)/include/dreamroq
	ln -s $(CURDIR)/include $(KOS_BASE)/include/dreamroq