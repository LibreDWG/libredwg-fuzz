#!/bin/sh
PRE=log.rw
POST=15
FUZZDIR=../.build-fuzz-asan
PROG="programs/dwgrewrite -v3"
RM='`basename $d`-rewrite.dwg'

source ./fuzzlib.sh

testcrashes
testhangs

#for d in ../.build-fuzz-asan/.fuzz-out$POST/crashes/id*
#do
#    $PROG "$d" >$ALL 2>&1
#    rm `basename $d`-rewrite.dwg 2>/dev/null
#    grep -5 'ERROR: AddressSanitizer' $ALL 2>&1 && (echo $d; echo) | tee -a $PRE-crashes$POST
#    grep -A15 'ERROR: LeakSanitizer' $ALL 2>&1 && (echo $d; echo) | tee -a $PRE-leaks$POST
#done
#
#for d in ../.build-fuzz-asan/.fuzz-out$POST/hangs/id*
#do
#    timeout 60 $PROG "$d" >$ALL 2>&1
#    [ $? == 124 ] && echo HANG && echo $d | tee -a $PRE-hangs$POST
#    rm `basename $d`-rewrite.dwg 2>/dev/null
#    grep -5 'ERROR: AddressSanitizer' $ALL 2>&1 && (echo $d; echo) | tee -a $PRE-crashes$POST
#    grep -A15 'ERROR: LeakSanitizer' $ALL 2>&1 && (echo $d; echo) | tee -a $PRE-leaks$POST
#done
rm $ALL
