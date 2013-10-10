#!/bin/bash

if [ $# == 1 ]
then
    interpreter=$1
else
    #interpreter="pypy"
    interpreter="python"
fi

files=$(find .. -type f | grep queries$ | grep -v query-processing)

for a in `echo "naive born paxson himbeault"`
#for a in `echo "naive born jhind paxson himbeault"`
#for a in `echo "born"`
do
#    for f in `echo "$files"`
#    do
#        g=$(echo $f | cut -d'/' -f3 | cut -d'.' -f1-3)
#        $interpreter $a.py $f 10 2>&1 >tun.$a.$g.$interpreter | tee tun.$a.$g.$interpreter.perf
#    done
#    done 2>&1 >tun.$a.$interpreter | tee tun.$a.$interpreter.perf

#    time xzcat qr.small.xz | $interpreter $a.py - 10 2>&1 > qr.$a.$interpreter | tee qr.$a.$interpreter.perf
#    pv q.small.xz | xzcat - | $interpreter $a.py - 10 2>&1 > qs.$a.$interpreter | tee qs.$a.$interpreter.perf > /dev/null
    pv /cygdrive/e/Persistent/q.big.xz | xzcat - | tail -n +2 | $interpreter $a.py - 10 2>&1 > qb.$a.$interpreter | tee qb.$a.$interpreter.perf > /dev/null
done
