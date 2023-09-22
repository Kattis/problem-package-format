package problem_package

#testdata_settings: {
	input_validator_flags?:  *"" | string | {[string]: string}
	output_validator_flags?: *"" | string
        grading?: {
		score?:       string
		max_score?:   string
		aggregation?: "sum" | "min"
	}
}

#testdata_settings
