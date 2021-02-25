#!/bin/sh
PRE=log.rw
POST=gh307
FUZZDIR=../test/issues/gh307
PROG="programs/dwgrewrite"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
