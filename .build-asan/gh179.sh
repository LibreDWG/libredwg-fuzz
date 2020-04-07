#!/bin/sh
for d in ../test/issues/gh179/id* ; do examples/dwg2svg2 -v3 $d 2>&1 | grep -5 Sanitizer && (echo $d; echo; rm `basename $d`.svg 2>/dev/null); done | tee log.svg2-gh179
