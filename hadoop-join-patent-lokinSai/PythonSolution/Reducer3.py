#!/usr/bin/env python
"""reducer.py"""

import sys

same_state_count = 0
curr_count = 0 
citing = None
curr_citing = None

# input comes from STDIN
for line in sys.stdin:
    
    # parse the input we got from mapper.py
    citing,cited_state,cited,citing_state,count = line.split("\t")

    # convert count (currently a string) to int
    try:
        count = int(count)
    except ValueError:
        # count was not a number, so silently
        # ignore/discard this line
        continue

    # this IF-switch only works because Hadoop sorts map output
    # by key (here: url) before it is passed to the reducer
    if curr_citing == citing:
        curr_count = curr_count + count
    else:
        if curr_citing:
                print(curr_citing+"\t"+str(curr_count))
                same_state_count = same_state_count + 1
        curr_count = count
        curr_citing = citing

if curr_citing == citing: 
    print(curr_citing+"\t"+str(curr_count))
    same_state_count = same_state_count + 1
