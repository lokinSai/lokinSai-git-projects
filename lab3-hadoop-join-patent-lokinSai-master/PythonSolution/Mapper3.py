#!/usr/bin/env python
"""mapper.py"""

import sys

# input comes from STDIN (standard input)
for line in sys.stdin:
    # split the line into CSV fields
    if line != '':
        line = line.strip()
        words = line.split(",")
        if len(words) == 4:
        #print(words)
            if (words[1] == words[3]) and words[1] != "-" and words[1] != '""':
                try:
                    print(words[0]+"\t"+words[1]+"\t"+words[2]+"\t"+words[3]+"\t"+"1")
                except Exception as e:
                    print("Exception", e)
            else:
                try:
                    print(words[0]+"\t"+words[1]+"\t"+words[2]+"\t"+words[3]+"\t"+"0")
                except Exception as e:
                    print("Exception", e)

            

