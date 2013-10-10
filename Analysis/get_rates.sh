#!/bin/bash

#for f in `echo "dns2tcp dnscat dnscat2 iodine prob-dns2"`
for f in `echo "prob-dns3"`
do
cat $f/out_c.txt | tr '\r' '\n' | \
sed -n 's/^Running \([0-9]*\) .*$/"\1"/p;s/^[^[]*\[[^0-9]*\([0-9][^]]*\)B\/s\].*$/\1/p' | \
sed 's/k/*1000/g;s/M/*1000000/g;s/e/E/g' | \
tr '"\n' '\n,' > rate.$f.c.csv

cat $f/out_s.txt | tr '\r' '\n' | \
sed -n 's/^Running \([0-9]*\) .*$/"\1"/p;s/^[^[]*\[[^0-9]*\([0-9][^]]*\)B\/s\].*$/\1/p' | \
sed 's/k/*1000/g;s/M/*1000000/g;s/e/E/g' | \
tr '"\n' '\n,' > rate.$f.s.csv
done
