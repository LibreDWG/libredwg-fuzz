#!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"

AFL_USE_ASAN=1 make -j4 -s -C src
AFL_USE_ASAN=1 make -j4 -s -C programs dwgwrite

afl-fuzz $@ -m none -i ../.fuzz-in-json -o .fuzz-out programs/dwgwrite -v0 -y -I json -o /dev/null @@
