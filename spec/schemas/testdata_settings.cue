package problemformat

#filename: =~ "^[a-zA-Z0-9][a-zA-Z0-9_.-]*[a-zA-Z0-9]$" // make these shorter?
#path: =~ "[a-zA-Z0-9_.-/]*"

#testdata_settings: {
	grading?:
        score?: number
        max_score: number
        aggregation: "sum" | "min"
        verdict: "first_error" | "accept_if_any_accepted" 
	input_validator_flags: *"" | string | { [string]: string }
	output_validator_flags: *"" | string
}