##!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/local/lib/afl
#export AFL_CC="clang"
set -e
echo core | sudo tee /proc/sys/kernel/core_pattern
export AFL_USE_ASAN=1
# with cmplog instrument all. encode and decode are by far the biggest.
# this binary can then be used with many options.
# possible mode: -injson -indxf -rw -dwg
# not possible: -dxf -dxfb -json
#export AFL_LLVM_WHITELIST=`pwd`/afl-whitelist-most
export AFL_LLVM_WHITELIST=`pwd`/afl-whitelist-rw
export AFL_LLVM_INSTRUMENT=CFG
#export AFL_LLVM_INSTRUMENT=CFG,NGRAM-2
export AFL_LLVM_INSTRIM_LOOPHEAD=1
export AFL_LLVM_INSTRIM_SKIPSINGLEBLOCK=1
export AFL_LLVM_LAF_SPLIT_SWITCHES=1
#export AFL_LLVM_LAF_TRANSFORM_COMPARES=1
#export AFL_LLVM_LAF_SPLIT_COMPARES=1
#export AFL_LLVM_LAF_ALL=1

if true; then
  export AFL_LLVM_CMPLOG=1
  make -j4 -s -C src clean
  test -f examples/dwgfuzz && rm examples/dwgfuzz
  time make -j4 -s -C src
  make -j4 -s -C examples dwgfuzz
  mv examples/dwgfuzz examples/dwgfuzz.cmplog
fi

unset AFL_LLVM_CMPLOG
make -j4 -s -C src clean
time make -j4 -s -C src
make -j4 -s -C examples dwgfuzz

mode=shift
./run-afl-clang-fast.sh $mode -c examples/dwgfuzz.cmplog $@
