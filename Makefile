# Put the filename of the output binary here
TARGET = libdreamroq.a

# List all of your C files here, but change the extension to ".o"
OBJS = dreamroq-player.o dreamroqlib.o
OBJS += libdcmc/timer.o

#AICA Audio Driver
KOS_CFLAGS += -I. -Ilibdcmc/
OBJS += libdcmc/roq_audio.o
OBJS += libdcmc/snddrv.o

# Install location (defaults to the KOS addons tree).
PREFIX     ?= $(KOS_BASE)/addons
INCLUDEDIR ?= $(PREFIX)/include/dreamroq
LIBDIR     ?= $(PREFIX)/lib/$(KOS_ARCH)

all: build

clean:
	-rm -f $(TARGET) $(OBJS) output.bin

link: $(OBJS)
	$(KOS_AR) rcs $(TARGET) $(OBJS)

build: $(OBJS) link

samples: build
	$(KOS_MAKE) -C samples all

install: build
	mkdir -p $(INCLUDEDIR) $(LIBDIR)
	cp -v include/*.h $(INCLUDEDIR)/
	cp -v $(TARGET) $(LIBDIR)/

uninstall:
	rm -rf $(INCLUDEDIR)
	rm -f $(LIBDIR)/$(TARGET)

include $(KOS_BASE)/Makefile.rules