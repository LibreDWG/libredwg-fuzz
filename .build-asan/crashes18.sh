#!/bin/sh
PRE=log.injson
POST=18
FUZZDIR=../.build-fuzz-asan
PROG="programs/dwgwrite -v3 -I json"
RM='`basename $d`.dwg'

make -s -j4

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
