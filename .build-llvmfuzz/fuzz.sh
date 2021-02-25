#!/bin/sh
set -x
make -j4 -s -C src && \
  clang -I../src -Isrc -g -fsanitize=address,fuzzer ../examples/llvmfuzz.c -Lsrc/.libs -lredwg
LD_LIBRARY_PATH=src/.libs ./a.out  -timeout=4000 -detect_leaks=0 -rss_limit_mb=24000 ../.fuzz-in-all/
