#!/bin/sh
PRE=log.layers
POST=gh308
FUZZDIR=../test/issues/gh308
PROG="programs/dwglayers"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
