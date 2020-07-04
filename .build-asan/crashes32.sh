#!/bin/sh
# 0.10.1.3619
PRE=log.rw
POST=32
FUZZDIR=../.build-fuzz-asan
PROG="programs/dwgrewrite -v3"

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
