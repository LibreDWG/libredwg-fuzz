#!/bin/sh
for d in ../test/issues/gh176/id*
do
    programs/dwg2dxf -y -v3 -o /dev/null $d 2>&1 | grep -5 Sanitizer && (echo $d; echo)
done | tee log.dxf-gh176
