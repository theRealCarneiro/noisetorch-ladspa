TARGET = rnnoise_ladspa.so

CCFLAGS = -Wall -Werror -O2 -c -fPIC

SRC = c-ringbuf/ringbuf.c rnnoise/src/*.c ladspa/module.c

WEBSITE_URL=https://github.com/therealcarneiro/noisetorch-ladspa
UPDATE_URL=${WEBSITE_URL}/releases/download/

UPDATE_PUBKEY = Md2rdsS+b6W0trgcqa5lAWP978Zj0sFmubJ252OPKwc=

${TARGET}: rnnoise
	$(CC) -I rnnoise/include ${CCFLAGS} ${SRC}
	$(CC) -o ${TARGET} *.o -shared -Wl,--version-script=ladspa/export.txt -lm

rnnoise:
	mkdir rnnoise
	mkdir c-ringbuf
	git submodule update --init --recursive

clean:
	rm -rf *.o ladspa/*.o ${TARGET}
