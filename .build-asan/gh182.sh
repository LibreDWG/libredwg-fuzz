#!/bin/sh
PRE=log.SVG
POST=gh182
FUZZDIR=../test/issues/gh182
PROG="programs/dwg2SVG -v3"
RM='`basename $d`.svg'

source ./fuzzlib.sh

testissue

rm $ALL

#for d in ../test/issues/gh182/id* ; do examples/dwg2SVG -v3 $d 2>&1 | grep -5 Sanitizer && (echo $d; echo; rm `basename $d`.svg 2>/dev/null); done | tee log.SVG-gh182
