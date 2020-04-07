#!/bin/sh
PRE=log.indxf
POST=gh186
FUZZDIR=../test/issues/gh186
PROG="programs/dxf2dwg -v3"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
