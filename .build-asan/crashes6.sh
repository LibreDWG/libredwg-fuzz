#!/bin/sh
PRE=log.indxf
POST=6
FUZZDIR=../.build-fuzz
PROG="programs/dxf2dwg -v3 -o /dev/null"

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
