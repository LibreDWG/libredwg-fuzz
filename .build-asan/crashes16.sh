#!/bin/sh
PRE=log.rw
POST=16
FUZZDIR=../.build-fuzz-asan
PROG="programs/dwgrewrite -v3"
RM='`basename $d`-rewrite.dwg'

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
