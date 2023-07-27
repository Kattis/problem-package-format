cue vet ../../examples/problem_full.yaml problem_package.cue
if [ $? -eq 0 ]; then
	echo "OK: Full examples accepted"
else
	echo "WARNING: Not all full examples accepted"
fi
cue vet ../../examples/problem_icpc.yaml problem_package.cue  -d "#icpc"
if [ $? -eq 0 ]; then
	echo "OK: ICPC examples accepted"
else
	echo "WARNING: Not all ICPC examples accepted"
fi
for f in ../../examples/problem_settings/invalid/*/problem.yaml; do
 	cue vet problem_package.cue "$f" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "WARNING: $f"
	fi
done
