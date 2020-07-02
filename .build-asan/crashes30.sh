#!/bin/sh
# 0.10.1.3589-8-g31999c7c
PRE=log.indxf
POST=30
FUZZDIR=../.build-fuzz-asan
PROG="programs/dxf2dwg -v3 -o /dev/null"

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
