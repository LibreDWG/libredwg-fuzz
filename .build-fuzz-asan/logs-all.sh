#!/bin/sh
# create logs for all DWGs with GNU parallel (fast)
# shellcheck disable=SC1001,SC1083
srcdir="/home/rurban/Software/libredwg"
abs_builddir="/home/rurban/Software/libredwg/.build-fuzz-asan"

make -s -j4

echo test/test-data
parallel timeout 10 ./libtool --mode=execute programs/dwgread -v4 {} \2\>{/.}.log ::: "$srcdir"/test/test-data/*.dwg

echo test/test-data/
cd "$srcdir/test/test-data" || exit
parallel timeout 30 "$abs_builddir/libtool" --mode=execute "$abs_builddir/programs/dwgread" -v4 {} \2\>$abs_builddir/{/.}_{//}.log ::: */*.dwg
cd "$abs_builddir" || exit

if test -d "$srcdir/test/test-big"; then
    echo test/test-big
    cd "$srcdir/test/test-big" || exit
    parallel timeout 30 "$abs_builddir/libtool" --mode=execute "$abs_builddir/programs/dwgread" -v3 {} \2\>$abs_builddir/{/.}_{//}.log ::: */*.dwg
    cd "$abs_builddir" || exit
fi

if test -d "$srcdir/test/test-old"; then
    echo test/test-old
    cd "$srcdir/test/test-old" || exit
    for d in r* 20*; do
        cd "$d" || exit
        parallel timeout 30 "$abs_builddir/libtool" --mode=execute "$abs_builddir/programs/dwgread" -v4 {} \2\>$abs_builddir/{/.}_{//}_"$d".log ::: */*.dwg
        cd .. || exit
    done
    cd "$abs_builddir" || exit
fi
