#!/usr/bin/env python3
import sys
from xml.sax.saxutils import escape

input_file = open(sys.argv[1]).read().strip()
answer_file = open(sys.argv[2]).read().strip()
args = sys.argv[3:]
with open("testcase.svg", "w") as f:
    print(f"<svg><text y='20'>args: {escape(' '.join(args))}</text></svg>", file=f)
