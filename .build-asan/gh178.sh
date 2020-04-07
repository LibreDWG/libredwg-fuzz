#!/bin/sh
PRE=log.rw
POST=gh178
ALL=.$PRE-$POST
rename 's/$/~/' $PRE-crashes$POST $PRE-hangs$POST $PRE-leaks$POST
touch $PRE-crashes$POST $PRE-hangs$POST $PRE-leaks$POST

for d in ../test/issues/gh178/*.dwg
do
    timeout 45 programs/dwgrewrite -v3 $d >$ALL 2>&1
    [ $? == 124 ] && echo HANG && echo $d | tee -a $PRE-hangs$POST
    rm `basename $d .dwg`-rewrite.dwg 2>/dev/null
    grep -5 'ERROR: AddressSanitizer' $ALL 2>&1 && (echo $d; echo) | tee -a $PRE-crashes$POST
    grep -A15 'ERROR: LeakSanitizer' $ALL 2>&1 && (echo $d; echo) | tee -a $PRE-leaks$POST
done
rm $ALL
