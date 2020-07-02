#!/bin/sh
# 0.10.1.3582
PRE=log.indxf
POST=29
FUZZDIR=../.build-fuzz-asan
PROG="programs/dxf2dwg -v3 -o /dev/null"

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
