#!/bin/bash

#Arg1: Base filename to use.

cat <(echo -n "{") <(for d in `cat ${1}u | sed 's/^.*"\(.*\)"$/\1/' | tr '\\\\' '.'`
do
cat <(echo "{\"$d\",{") <(grep "\"$d\"" ${1} | cut -d ',' -f1 | tr '\n' ',') <(echo -n "}},")
done | sed 's/,}/}/' | head -c -1) <(echo -n "}")

