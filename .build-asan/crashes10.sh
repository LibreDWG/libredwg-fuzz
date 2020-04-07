#!/bin/sh
PRE=log.injson
POST=10
FUZZDIR=../.build-fuzz
PROG="programs/dwgwrite -v3 -I json"
RM='`basename $d`.dwg'

make -s -j4

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
