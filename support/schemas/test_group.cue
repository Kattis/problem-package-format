package problem_package

#test_group_settings: {
	input_validator_flags?:  *"" | string | {[string]: string}
	output_validator_flags?: *"" | string
	grading?: {
		score?:       number
		max_score?:   number
		aggregation?: "sum" | "min"
	}
}

#test_group_settings
