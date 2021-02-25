#!/bin/sh
PRE=log.json
POST=gh306
FUZZDIR=../test/issues/gh306
PROG="programs/dwgread -Ojson"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
