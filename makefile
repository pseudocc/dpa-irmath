PREFIX=/usr/local

BINDIR=$(PREFIX)/bin

all: libadvmath.so

math.bc: math.ll
	llvm-as $^ -o $@

math.o: math.bc
	llc $^ -o $@ -filetype=obj --relocation-model=pic

libadvmath.so: math.o
	clang -shared -o $@ $^

install: libadvmath.so
	install -d $(BINDIR)
	install $^ $(BINDIR)/libadvmath.so

clean:
	rm -f libadvmath.so math.o math.bc

.PHONY: install clean
