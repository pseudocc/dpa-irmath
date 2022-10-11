PREFIX=/usr/local

LIBDIR=$(PREFIX)/lib
INCDIR=$(PREFIX)/include/libadvmath

all: libadvmath.so

math.bc: math.ll
	llvm-as $^ -o $@

math.o: math.bc
	llc $^ -o $@ -filetype=obj --relocation-model=pic

libadvmath.so: math.o
	clang -shared -o $@ $^

install: libadvmath.so
	install -d $(LIBDIR)
	install -d $(INCDIR)
	install -m 644 math.h $(INCDIR)/math.h
	install libadvmath.so $(LIBDIR)/libadvmath.so.2

clean:
	rm -f libadvmath.so math.o math.bc

.PHONY: install clean
