#!/bin/sh
set -e
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/lib64/afl
export AFL_CC="clang"
echo core | sudo tee /proc/sys/kernel/core_pattern 2>/dev/null || true
#export AFL_LLVM_WHITELIST=`pwd`/afl-whitelist-rw
#export AFL_LLVM_INSTRIM=1
#export AFL_LLVM_INSTRIM_LOOPHEAD=1
#export AFL_LLVM_INSTRIM_SKIPSINGLEBLOCK=1
#export AFL_LLVM_LAF_ALL=1

CC=gcc CXX=g++ make -j1
AFL_USE_ASAN=1 make -j1 -C programs dwgrewrite

./run-afl-clang-fast-rw.sh $@
