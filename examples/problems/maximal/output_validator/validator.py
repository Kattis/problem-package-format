import sys

try:
	in_file: str = sys.argv[1]
except IndexError:
	sys.exit(43) # Rejected

try:
	output: str = str(sys.stdin.read())
except UnicodeDecodeError:
	sys.exit(43) # Rejected

try:
	indata: str
	with open(in_file) as f:
		indata = f.read()
except:
	sys.exit(43) # Rejected

try:
	if abs(int(output) - int(indata)) == {{example_constant}}:
		sys.exit(42) # Accepted
	else:
		sys.exit(43) # Rejected
except ValueError:
	sys.exit(43) # Rejected
