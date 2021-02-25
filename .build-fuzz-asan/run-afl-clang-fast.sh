#!/bin/sh
export ASAN_OPTIONS="abort_on_error=1:detect_leaks=0:symbolize=0:allocator_may_return_null=1"
export AFL_PATH=/usr/local/lib/afl
# required mode as 1st arg: -rw -indxf ...
# or - -indxf to continue into the same outdir.
mode=$1
shift

in=../.fuzz-in
case $mode in
    -injson) in=../.fuzz-in-json ;;
    -indxf)  in=../.fuzz-in-dxf ;;
    -)
        in=-;
        mode=$1
        shift
        case $mode in
            -injson) in=../.fuzz-in-json ;;
            -indxf)  in=../.fuzz-in-dxf ;;
        esac
        ;;
esac

# recidivm -u M examples/dwgfuzz -rw ../td/examples_2010.dwg => 20972024
args="$* -m 21500000 -i $in -o .fuzz-out"
case "$@" in
    *-L*)
        ;;
    *-R*) args="$args -L -1"
        ;;
    *)  args="$args -L 5"
        ;;
esac
if [ -e examples/dwgfuzz.cmplog ]; then
    args="$args -c examples/dwgfuzz.cmplog"
fi
# no dwgfuzz args needed, just the mode
afl-fuzz $args -- examples/dwgfuzz $mode
