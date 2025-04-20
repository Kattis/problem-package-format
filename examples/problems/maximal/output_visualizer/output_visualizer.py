#!/usr/bin/env python3
import sys
from xml.sax.saxutils import escape

input_file = open(sys.argv[1]).read().strip()
answer_file = open(sys.argv[2]).read().strip()
feedback_dir = sys.argv[3]
args = sys.argv[4:]
with open(f"{feedback_dir}/judgeimage.svg", "w") as f:
    print(f"<svg><text>args: {escape(' '.join(args))}</text><text>team output: {input()}</text></svg>", file=f)
