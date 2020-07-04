##!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/local/lib/afl
# required mode as 1st arg: -rw -indxf ...
mode=shift

# no dwgfuzz args needed, just the mode
afl-fuzz $@ -m none -L 10 -i ../.fuzz-in -o .fuzz-out \
  examples/dwgfuzz $mode
