echo "Valid problem.yaml"
echo "=================="
echo 

for f in ../../examples/problem_settings/valid/*/problem.yaml; do
	echo $f
	cue vet problem_package.cue "$f" -d "#problem_settings"
	echo $? 
	echo
done

echo "Invalid problem.yaml"
echo "===================="
echo 
for f in ../../examples/problem_settings/invalid/*/problem.yaml; do
	echo $f
	cue vet problem_package.cue "$f" -d "#problem_settings"
done
