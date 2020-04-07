#!/bin/sh
# create logs for all DWGs with GNU parallel (fast)
srcdir=".."
abs_builddir="/home/rurban/Software/libredwg/.build-fuzz-asan"

make -s -j4

# shellcheck disable=SC1001,SC1083
parallel timeout 10 ./libtool --mode=execute programs/dwgread -v4 {} \2\>{/.}.log ::: "$srcdir"/test/test-data/*.dwg

cd "$srcdir/test/test-data" || exit
# shellcheck disable=SC1001,SC1083
parallel timeout 10 "$abs_builddir"/libtool --mode=execute "$abs_builddir"/programs/dwgread -v4 {} \2\>$abs_builddir/{/.}_{//}.log ::: */*.dwg
cd "$abs_builddir" || exit

if test -d "$srcdir/test/test-big"
then
    cd "$srcdir/test/test-big" || exit
    # shellcheck disable=SC1001,SC1083
    parallel timeout 30 "$abs_builddir"/libtool --mode=execute "$abs_builddir"/programs/dwgread -v3 {} \2\>$abs_builddir/{/.}_{//}.log ::: */*.dwg
    cd "$abs_builddir" || exit
fi
