#!/bin/env python

# Arg1: Duration, in seconds, of a window

import sys
import math
from collections import deque

# http://en.wikipedia.org/wiki/Ethernet_frame#Structure
# Preamble       = 7
# Start delim    = 1
# FCS            = 4
# Interframe gap = 12
# Total         == 24
frame_padd = 7 + 1 + 4 + 12
#frame_padd = 0

if len(sys.argv) < 3:
    print "USAGE: tp_plot.py <duration, in seconds, of an interval> <line rate in bits per second>"
    exit(1)

dt = float(sys.argv[1])
rate = float(sys.argv[2])
bpi = rate * dt

print "Processing file for", dt, "second intervals at", rate, "bits per second (", bpi, " bits per interval)"

cur_bits = 0
ti = 1 #Portion of interval remaining
cur_interval = 0

last_time = 0

pkt_num = 0
rates = deque()
rates.append([0,0])

for l in sys.stdin:
    # Grab the data and parse
    [ stime, sbytes ] = l.split(",")
    t = float(stime)
    ( ti, ii ) = math.modf(t / dt)
    bits = 8 * (int(sbytes) + frame_padd)
    ti = 1 - ti

    # Ensure monotonicity of timestamps.
    # Bail ungracefully if this fails
    if t < last_time:
        print "TIMESTAMPS ARE NON-MONOTONIC! Exiting."
        exit(2)
    else:
        last_time = t

    # Check to see if we've moved to the next interval
    # If we have, output any accumulations for intervals before the current one
    # We are assuming monotonicity of timestamps here.
    if ii > cur_interval:
        cur_interval = ii
        if rates[-1][0] != ii:
            rates.append([ii,0])
        while rates[0][0] < ii:
            r = rates.popleft()
            print r[1] / dt

    # Now add the current packet's data
    # Find the start interval, typically going to be the first.
    i = int(ii - rates[0][0])

    while bits > 0:
        if i == len(rates):
            rates.append([ii+1,0])

        cur_bits = min(bits, ti * bpi)
        bits -= cur_bits
        rates[i][1] += cur_bits
        cur_bits = 0
        ti = 1
        i += 1

    pkt_num += 1

for r in rates:
    print r[1]
