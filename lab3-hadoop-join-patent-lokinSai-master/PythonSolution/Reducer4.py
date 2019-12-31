#!/usr/bin/env python
"""reducer.py"""

import sys

current_citing = "-"
currnet_count = "0"
# input comes from STDIN
for line in sys.stdin:
    line = line.strip()
    citing,other_patent_info,citing_count = line.split("\t")

    if not current_citing or current_citing != citing:
        current_citing = citing
        current_count = citing_count
    elif citing == current_citing:
        citing_count = current_count
        print(citing+","+other_patent_info+","+citing_count)
    
