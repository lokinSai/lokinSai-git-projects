#!/usr/bin/env python
"""mapper.py"""

import sys

for line in sys.stdin:
    if line != '':
        line = line.strip()
        citing = "-"
        cited = "-"
        state = "-"
        citing_state = "-"
        words = line.split(",")
        if len(words)==3:
        #
        # It's output from reducer1.py
        #
            try:
                citing = words[0]
                cited = words[1]
                citing_state = words[2]
                #print("reducer op",citing,cited,citing_state,state)
            except Exception as e:
                # improperly formed citation number
                print("Exception ", e)
                pass
        elif len(words) > 3:
        #
        # It's patent info 
        #
            try:
            # cite = long(words[0])
                cited = words[0]
                state = words[5]
                #print("other",citing,cited,citing_state,state)
            except Exception as e:
            # improperly formed citation number
                print("Exception ", e)
                pass

        print(cited+"\t"+citing+"\t"+citing_state+"\t"+state)
