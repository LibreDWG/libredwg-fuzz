#!/bin/sh
make -j4 -s clean
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_CC="clang"
#export AFL_LLVM_INSTRIM=1
#export AFL_LLVM_INSTRIM_LOOPHEAD=1
#export AFL_LLVM_INSTRIM_SKIPSINGLELOCK=1

PERL=perl \
CC="afl-clang-fast" \
AR="llvm-ar" \
RANLIB="llvm-ranlib" \
CFLAGS="-DDWG_LOGLEVEL=0 -O2 -g -fsanitize=address,undefined -fno-omit-frame-pointer" \
    ~/Software/libredwg/configure --disable-shared --disable-bindings --disable-werror $@

# ./make-afl-clang-fast.sh
