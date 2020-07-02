#!/bin/sh
# 0.10.1.3490
PRE=log.indxf
POST=26
FUZZDIR=../.build-fuzz-asan
PROG="programs/dxf2dwg -v3 -o /dev/null"

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
