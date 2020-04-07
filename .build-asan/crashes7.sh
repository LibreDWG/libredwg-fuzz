#!/bin/sh
PRE=log.rw
POST=7
FUZZDIR=../.build-fuzz
PROG="programs/dwgrewrite -v3"
RM='`basename $d`-rewrite.dwg'

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
