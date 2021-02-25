#!/bin/sh
PRE=log.SVG
POST=gh305
FUZZDIR=../test/issues/gh305
PROG="programs/dwg2SVG"
RM='`basename $d`.dwg'

source ./fuzzlib.sh

testissue

rm $ALL
