##!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/local/lib/afl

# all args are now ignored
afl-fuzz $@ -m none -L 10 -i ../.fuzz-in -o .fuzz-out \
  programs/dwgrewrite @@
