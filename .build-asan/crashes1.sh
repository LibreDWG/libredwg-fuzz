#!/bin/sh
PRE=log.indxf
POST=1
PROG="programs/dxf2dwg -v3 -o /dev/null"

source ./fuzzlib.sh

testcrashes
testhangs

rm $ALL
