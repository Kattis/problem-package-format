echo "Valid problem.yaml"
echo "=================="
echo 

for f in ../../examples/problem_settings/*/*/problem.yaml; do
	echo $f
	cue vet problem_package.cue "$f" -d "#problem_settings"
	echo $? 
	cue vet problem_package.cue "$f" -d "#problem_settings_icpc"
	echo $? 
	echo
done
