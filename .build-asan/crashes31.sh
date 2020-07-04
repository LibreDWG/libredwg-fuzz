#!/bin/sh
# 0.10.1.3603-10-g7e9424b1
PRE=log.indxf
POST=31
FUZZDIR=../.build-fuzz-asan
PROG="programs/dxf2dwg -v3 -o /dev/null"

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
