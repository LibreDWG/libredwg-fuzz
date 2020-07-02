##!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/local/lib/afl

# -L 10 clashes with -R
afl-fuzz $@ -m none -i ../.fuzz-in-dxf -o .fuzz-out \
  programs/dwgwrite -v0 -y -I dxf -o /dev/null @@
