#!/bin/sh
PRE=log.rw
POST=gh309
FUZZDIR=../test/issues/gh309
PROG="programs/dwgrewrite"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
