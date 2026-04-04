#!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
#export AFL_CC="gcc"
CC="ccache afl-gcc-fast" \
CFLAGS="-m32 -O1 -g -fsanitize=address -fno-omit-frame-pointer -I/usr/local/include" \
    ~/Software/libredwg/configure --disable-shared --disable-bindings $@

./make-afl-asan-json.sh
