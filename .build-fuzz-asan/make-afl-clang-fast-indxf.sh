##!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/local/lib/afl
#export AFL_CC="clang-10"
echo core | sudo tee /proc/sys/kernel/core_pattern
set -e
export AFL_LLVM_WHITELIST=`pwd`/afl-whitelist-indxf
export AFL_LLVM_INSTRIM=1
#export AFL_LLVM_INSTRIM_LOOPHEAD=1
export AFL_LLVM_INSTRIM_SKIPSINGLEBLOCK=1
export AFL_LLVM_LAF_SPLIT_SWITCHES=1
#export AFL_LLVM_LAF_TRANSFORM_COMPARES=1
#export AFL_LLVM_LAF_SPLIT_COMPARES=1
#export AFL_LLVM_LAF_ALL=1

AFL_USE_ASAN=1 make -j4 -s -C src
# AR=llvm-ar-10 RANLIB=llvm-ranlib-10 
AFL_USE_ASAN=1 make -j4 -s -C examples dwgfuzz

./run-afl-clang-fast-indxf.sh $@
