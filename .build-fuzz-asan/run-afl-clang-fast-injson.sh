##!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/local/lib/afl

# all args are now ignored. old: -v0 -y -I json -o /dev/null
afl-fuzz $@ -m none -L 10 -i ../.fuzz-in-json -o .fuzz-out \
  examples/dwgfuzz -injson @@

# programs/dwgwrite -v0 -y -I json -o /dev/null @@
