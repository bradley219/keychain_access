TARGET    = keychain_access
VERSION   = v2
REV       = $(shell git rev-parse --short=4 HEAD || cat git-rev)

DEBUG     = -g
# DEBUG   = -O2
DEFINES   = -DKCA_VERSION=\"$(VERSION)\"

# If we somehow found a revision number
ifneq ($(REV),)
DEFINES  += -DKCA_REV=\"$(REV)\"
endif

CFLAGS    += -pipe -std=c99 -Wall -pedantic $(DEBUG) $(DEFINES)
SRC_FILES = $(wildcard *.c)
O_FILES   = $(SRC_FILES:%.c=%.o)
LIBS      = $(LDFLAGS) -framework Security -framework CoreFoundation -lcrypto


.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(O_FILES)
	gcc $(O_FILES) -o $(TARGET) $(LIBS)

clean:
	rm -f *.o $(TARGET)

run: $(TARGET)
	./$(TARGET)

install:
	@echo No yet implemented, just copy the file yourself.
