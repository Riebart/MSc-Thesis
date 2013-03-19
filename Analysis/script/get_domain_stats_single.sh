#!/bin/bash

#Arg1: Number of lines to take. This is 2*(Number of domains I want)
#Arg2: Where to look for xml files

for f in $1/*xml
do
cat $f | grep -E "DomainLength-WeightedEntropy" | sed -n 's/.*<.*>\(.*\)<\/.*>.*$/\1/p' > $f.ent
cat $f | grep -E "RegisteredDomain" | sed -n 's/.*<.*>\(.*\)<\/.*>.*$/\1/p' | sed 's/\\/\\\\/g;s/"/\\"/g' | sed 's/^.*$/"&"/' > $f.dom
done
