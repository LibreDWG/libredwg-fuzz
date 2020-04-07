##!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/local/lib/afl
export AFL_CC="clang"
echo core | sudo tee /proc/sys/kernel/core_pattern
set -e
export AFL_LLVM_WHITELIST=`pwd`/afl-whitelist-json

AFL_USE_ASAN=1 make -j4 -s -C src
AFL_USE_ASAN=1 make -j4 -s -C programs dwgwrite

./run-afl-clang-fast-injson.sh $@
