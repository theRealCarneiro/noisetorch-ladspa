CCFLAGS = -Wall -Werror -O2 -c -fPIC

TARGET = rnnoise_ladspa.so
SRC = c-ringbuf/ringbuf.c rnnoise/src/*.c ladspa/module.c

UPDATE_PUBKEY = Md2rdsS+b6W0trgcqa5lAWP978Zj0sFmubJ252OPKwc=

all: rnnoise ${TARGET}

rnnoise:
	git submodule update --init --recursive

${TARGET}: rnnoise
	$(CC) -I rnnoise/include ${CCFLAGS} ${SRC}
	$(CC) -o ${TARGET} *.o -shared -Wl,--version-script=ladspa/export.txt -lm

clean:
	rm -rf *.o ladspa/*.o ${TARGET}

.PHONY: all rnnoise clean
