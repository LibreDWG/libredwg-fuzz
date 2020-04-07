#!/bin/sh
PRE=log.indxf
POST=gh190
FUZZDIR=../test/issues/gh190
PROG="programs/dxf2dwg -v3"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
