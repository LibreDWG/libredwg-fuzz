#!/bin/sh
# 0.10.1.3524 == 0.10.1.3490-66-ge2f6fff2
PRE=log.indxf
POST=27
FUZZDIR=../.build-fuzz-asan
PROG="programs/dxf2dwg -v3 -o /dev/null"

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
