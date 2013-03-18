#!/bin/bash

cat - | sort -t',' -k2 -r | uniq -c -f 2 | sort -rn
