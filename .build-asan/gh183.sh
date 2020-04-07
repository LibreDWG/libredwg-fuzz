#!/bin/sh
PRE=log.dxf
POST=gh183
FUZZDIR=../test/issues/gh183
PROG="programs/dwg2dxf -v3"
RM='`basename $d`.dxf'

source ./fuzzlib.sh

testissue

rm $ALL
