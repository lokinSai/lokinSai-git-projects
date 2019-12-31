#!/usr/bin/env python
"""mapper.py"""

import sys

# input comes from STDIN (standard input)
for line in sys.stdin:
    # split the line into CSV fields
    line = line.strip()
    words = line.split(",")
    citing = "-"
    cited = "-"
    state = "-"
    if len(words) == 2:
        #
        # It's a citation
        #
        try:
            citing = words[0]
            cited = words[1]
            #print("citing and cited",citing,cited)
        except Exception as e:
            # improperly formed citation number
            print("Exception ", e)
            pass
    else:
        #
        # It's patent info 
        #
        try:
            # cite = long(words[0])
            citing = words[0]
            state = words[5]
            #print("cited and state",cited,state)
        except Exception as e:
            # improperly formed citation number
            print("Exception ", e)
            pass

    print(citing+"\t"+cited+"\t"+state)

