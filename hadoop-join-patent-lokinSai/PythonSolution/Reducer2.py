#!/usr/bin/env python
"""reducer.py"""

import sys,string

previous_cited_id = "-"
current_cited_state = "-"

for line in sys.stdin:
    line = line.strip()
    
    cited,citing,citing_state,state = line.split("\t")

    if not previous_cited_id or previous_cited_id != cited:
        previous_cited_id = cited
        current_cited_state = state
    elif cited == previous_cited_id:
        state = current_cited_state
        print(citing+","+state+","+cited+","+citing_state)
