#!/bin/sh
test -n "$FUZZDIR" || FUZZDIR=../.build-fuzz
test -n "$PROG" || PROG="programs/dxf2dwg -v3 -o /dev/null"
test -n "$RM" || RM='`basename "$d"`.dwg'
# simplify leak test: (temporary)
if [ $PRE = log.rw ]; then PROG="programs/dwgread -v3"; fi

case $FUZZDIR in
    ../test/issues*)
        CRASHES=$FUZZDIR
        HANGSS=$FUZZDIR
        rename 's/$/~/' $PRE-$POST $PRE-hangs$POST $PRE-leaks$POST
        touch $PRE-$POST $PRE-hangs$POST $PRE-leaks$POST
        ;;
    *)
        CRASHES=$FUZZDIR/.fuzz-out$POST/crashes
        HANGS=$FUZZDIR/.fuzz-out$POST/hangs
        rename 's/$/~/' $PRE-crashes$POST $PRE-hangs$POST $PRE-leaks$POST
        touch $PRE-crashes$POST $PRE-hangs$POST $PRE-leaks$POST
        ;;
esac
                
ALL=.$PRE-$POST

testissue () {
    ASAN_OPTIONS="allocator_may_return_null=1 detect_leaks=1 symbolize=1"
    for d in $CRASHES/id*
    do
        timeout 15 $PROG "$d" >$ALL 2>&1
        [ $? == 124 ] && echo HANG && echo $d | tee -a $PRE-hangs$POST
        eval "rm $RM" 2>/dev/null
        (grep -a -5 'ERROR: AddressSanitizer' $ALL && echo $d && echo) | tee -a $PRE-$POST
        (grep -a -A15 'ERROR: LeakSanitizer' $ALL && echo $d && echo) >> $PRE-leaks$POST
        if [ $PRE != log.indxf ]; then
            (grep -a -A2 'Direct leak of ' $ALL | grep -v _interceptor_) && echo $d && echo
        fi
    done
}

testcrashes () {
    ASAN_OPTIONS="allocator_may_return_null=1 detect_leaks=1 symbolize=1"
    for d in $CRASHES/id*
    do
        timeout 15 $PROG "$d" >$ALL 2>&1
        [ $? == 124 ] && echo HANG && echo $d | tee -a $PRE-hangs$POST
        eval "rm $RM" 2>/dev/null
        (grep -a -5 'ERROR: AddressSanitizer' $ALL && echo $d && echo) | tee -a $PRE-crashes$POST
        (grep -a -A15 'ERROR: LeakSanitizer' $ALL && echo $d && echo) >> $PRE-leaks$POST
        if [ $PRE != log.indxf ]; then
            (grep -a -A2 'Direct leak of ' $ALL | grep -v _interceptor_) && echo $d && echo
        fi
    done
}

testhangs () {
    ASAN_OPTIONS="allocator_may_return_null=1 detect_leaks=1 symbolize=1"
    for d in $HANGS/id*
    do
        timeout 30 $PROG "$d" >$ALL 2>&1
        [ $? == 124 ] && echo HANG && echo $d | tee -a $PRE-hangs$POST
        eval "rm $RM" 2>/dev/null
        (grep -a -5 'ERROR: AddressSanitizer' $ALL && echo $d && echo) | tee -a $PRE-crashes$POST
        (grep -a -A15 'ERROR: LeakSanitizer' $ALL && echo $d && echo) >> $PRE-leaks$POST
        if [ $PRE != log.indxf ]; then
            (grep -a -A2 'Direct leak of ' $ALL | grep -v _interceptor_) && echo $d && echo
        fi
    done
}
