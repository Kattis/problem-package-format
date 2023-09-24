package problem_package

#testdata_settings: {
	input_validator_flags?:  *"" | string | {[string]: string}
	output_validator_flags?: *"" | string
        grading?: {
		score?:       number
		max_score?:   number
		aggregation?: "sum" | "min"
	}
}

#testdata_settings
