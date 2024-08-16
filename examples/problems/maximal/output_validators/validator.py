import sys

[_, in_file, ans_file, feedback_dir] = sys.argv
output: str = sys.stdin.read()

indata: str
with open(in_file) as f:
	indata = f.read()

try:
	if abs(int(output) - int(indata)) == {{example_constant}}:
		sys.exit(42) # Accepted
	else:
		sys.exit(43) # Rejected
except ValueError:
	sys.exit(43) # Rejected
