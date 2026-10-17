# Output library and object files live under build/
TARGET = build/libdreamroq.a
BUILD  = build

# List all of your C files here
SRCS  = dreamroq-player.c dreamroqlib.c
SRCS += libdcmc/timer.c
SRCS += libdcmc/roq_audio.c
SRCS += libdcmc/snddrv.c

#AICA Audio Driver
KOS_CFLAGS += -I. -Ilibdcmc/

OBJS = $(SRCS:%.c=$(BUILD)/%.o)

# Install location (defaults to the KOS addons tree).
PREFIX     ?= $(KOS_BASE)/addons
INCLUDEDIR ?= $(PREFIX)/include/dreamroq
LIBDIR     ?= $(PREFIX)/lib/$(KOS_ARCH)

.PHONY: all build install uninstall samples clean

all: build

$(BUILD)/%.o: %.c
	@mkdir -p $(@D)
	kos-cc $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(TARGET): $(OBJS)
	$(KOS_AR) rcs $@ $(OBJS)

build: $(TARGET)

install: build
	mkdir -p $(INCLUDEDIR) $(LIBDIR)
	cp -v include/*.h $(INCLUDEDIR)/
	cp -v $(TARGET) $(LIBDIR)/

uninstall:
	rm -rf $(INCLUDEDIR)
	rm -f $(LIBDIR)/libdreamroq.a

samples: install
	$(KOS_MAKE) -C samples all

clean:
	-rm -rf $(BUILD) output.bin

include $(KOS_BASE)/Makefile.rules