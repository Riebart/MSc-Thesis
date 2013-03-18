#!/bin/bash

#Arg1: Number of lines to take. This is 2*(Number of domains I want)
#Arg2: Where to look for xml files

for f in $2/*xml
do
cat $f | grep -E "(RegisteredDomain|DomainLength-WeightedEntropy)" | head -n $1
done | sed -n 'N;s/.*<.*>\(.*\)<\/.*>.*<.*>\(.*\)<\/.*>.*$/\2  ,  "\1"/p' | sort -rn

