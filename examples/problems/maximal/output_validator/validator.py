import sys

[_, in_file, ans_file, feedback_dir] = sys.argv
output = sys.stdin.read()

if output.isdigit() and int(output) == 42:
	sys.exit(42) # Accepted
else:
	sys.exit(43) # Rejected
