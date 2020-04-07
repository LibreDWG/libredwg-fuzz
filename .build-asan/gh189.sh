#!/bin/sh
PRE=log.indxf
POST=gh189
FUZZDIR=../test/issues/gh189
PROG="programs/dxf2dwg -v3"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
