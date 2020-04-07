#!/bin/sh
PRE=log.bmp
POST=gh188
FUZZDIR=../test/issues/gh188
PROG="programs/dwgbmp -v3"
RM='`basename $d`.bmp'

source ./fuzzlib.sh

testissue

rm $ALL
