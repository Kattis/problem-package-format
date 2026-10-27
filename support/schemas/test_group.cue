package problem_package

// Configuration of a test data group, secret, sample, or a validation test data directory (test_group.yaml).
#test_group_settings: {
	// The maximum possible score of the test data group or secret. Not permitted in sample.
	max_score?: int & >=0 | "unbounded"
	// How the score is determined from the contained groups or test cases. Not permitted in sample.
	score_aggregation?: "pass-fail" | "sum" | "min"
	// How the output validator and static validator report the score of an accepted test case. Not permitted in sample.
	score_mode?: "none" | "absolute" | "relative"
	// The maximum score of the static validation test case, or "pass-fail".
	static_validation_score?: int & >=0 | "pass-fail"
	// Other test data groups (or sample) whose test cases must be passed to receive a score for this group. Not permitted in sample.
	require_pass?: string | [...string]
	// Command-line arguments for the submission.
	args?: [...string]
	// Arguments for every input validator, or per input validator by name.
	input_validator_args?: [...string] | {[string]: [...string]}
	static_validator_args?:  [...string]
	output_validator_args?:  [...string]
	input_visualizer_args?:  [...string]
	output_visualizer_args?: [...string]
	// Whether solvers get extended feedback when failing a test case. Defaults to true in sample, false otherwise.
	full_feedback?: bool
}

#test_group_settings
