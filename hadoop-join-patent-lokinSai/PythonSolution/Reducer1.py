#!/usr/bin/env python
"""reducer.py"""

import sys,string

previous_citing_id = "-"
current_state = "-"

for line in sys.stdin:
    citing,cited,state = line.split("\t")

    if not previous_citing_id or previous_citing_id != citing:
        previous_citing_id = citing
        current_state = state
    elif citing == previous_citing_id:
        state = current_state
        print(citing+","+cited+","+state)

