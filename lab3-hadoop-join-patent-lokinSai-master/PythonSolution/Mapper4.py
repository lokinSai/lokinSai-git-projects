#!/usr/bin/env python
"""mapper.py"""

import sys

#input comes from STDIN (standard input)
for line in sys.stdin:
    citing = "-"
    citing_count = 0
    other_patent_info = "-"
    # split the line by comma
    line = line.strip()
    words = line.split(",")
    if len(words) == 2:
        # from reducer3.py
        try:
            citing = words[0]
            citing_count = words[1]
        except Exception as e:
            print("Exception",e)

    else:
        # from patent info
        try:
            citing = words[0]
            other_patent_info = ",".join(words[1:])
        except Exception as e:
            print("Exception",e)
            
    print(citing+"\t"+other_patent_info+"\t"+str(citing_count))
