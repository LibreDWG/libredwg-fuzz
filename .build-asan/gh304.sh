#!/bin/sh
PRE=log.dwg
POST=gh304
FUZZDIR=../test/issues/gh304
PROG="programs/dwgread -v3"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
