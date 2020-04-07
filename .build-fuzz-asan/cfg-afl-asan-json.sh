#!/bin/sh
make -j4 -s clean
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_CC="gcc"
PERL=cperl5.30.0-nt \
CC="afl-gcc" \
CFLAGS="-m32 -O2 -g -fsanitize=address,undefined -fno-omit-frame-pointer -I/usr/local/include" \
    ../configure --disable-shared --disable-bindings $@

./make-afl-asan-json.sh
