cue vet ../../examples/problem_full.yaml problem_package.cue
if [ $? -eq 0 ]; then
	echo "OK: Full examples accepted"
else
	echo "WARNING: Not all full examples validated"
fi
cue vet ../../examples/problem_icpc.yaml problem_package.cue  -d "#icpc"
if [ $? -eq 0 ]; then
	echo "OK: ICPC examples accepted"
else
	echo "WARNING: Not all ICPC examples validated against #icpc"
fi

output_dir="tmp"
mkdir -p  "$output_dir/full"

# Check that "full" problems in examples/problem_full.yaml
# are *rejected* by the #icpc subset (so either something
# is wrong or the example should be moved to examples/problem_icpc.yaml)

counter=0
awk -v RS='---' -v output_dir="$output_dir" '
	{
		file_counter++;
		output_file = output_dir "/full/problem_" file_counter ".yaml"
		print $0 > output_file;

	}' ../../examples/problem_full.yaml

for f in $output_dir/full/*.yaml; do
 	cue vet problem_package.cue -d "#icpc" "$f" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "WARNING: $f not rejected by #icpc"
	fi
done

# Check that invalid problems in examples/problem_invalid.yaml
# are indeed *rejected* 

counter=0
mkdir -p  "$output_dir/invalid"
awk -v RS='---' -v output_dir="$output_dir" '
	{
		file_counter++;
		output_file = output_dir "/invalid/problem_" file_counter ".yaml"
		print $0 > output_file;

	}' ../../examples/problem_invalid.yaml

for f in $output_dir/invalid/*.yaml; do
 	cue vet problem_package.cue "$f" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		echo "WARNING: $f not rejected"
	fi
done
