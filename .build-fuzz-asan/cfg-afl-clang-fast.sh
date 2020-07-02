#!/bin/sh
make -j4 -s clean
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_CC="clang-10"
export AFL_LLVM_INSTRIM=1
export AFL_LLVM_INSTRIM_LOOPHEAD=1
export AFL_LLVM_INSTRIM_SKIPSINGLELOCK=1

PERL=cperl5.30.0-nt \
CC="afl-clang-fast" \
AR="llvm-ar-10" \
RANLIB="llvm-ranlib-10" \
CFLAGS="-O2 -g -fsanitize=address,undefined -fno-omit-frame-pointer" \
    ../configure --disable-shared --disable-bindings $@

# ./make-afl-clang-fast.sh
