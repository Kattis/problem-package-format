#problem_settings_icpc: {
	name:                    string | close({[#language_code]: string})
	problem_format_version?: *"legacy" | "draft" | =~"^[0-9]{4}-[0-9]{2}(-icpc)(-draft)?$"
	type?:                   *"pass-fail" | "scoring"
	if problem_format_version !~ "icpc" {type?: "pass-fail"}

	["author" | "source"]: string
	if source != _|_ {source_url?: string}

	license?: *"unknown" | "public domain" | "cc0" | "cc by" | "cc by-sa" | "educational" | "permission"
	if license != _|_ && license != "public domain" {
		rights_owner?: string
		// if license =~ "unknown" { numexists(>=1, rights_owner, author, source) }
	}
	limits?: {
		time_multiplier?: {
			ac_to_time_limit:  *2.0 | float
			time_limit_to_tle: *1.5 | float
		}
		time_limit?:      number & >0
		time_resolution?: *1.0 | float
		[#other_limits]:  int
	}
	validation?: *"default" | "custom" | {
		"interactive": *false | true
		... // other keys are allowed but ignored
	}
	keywords?: string | [...string]
	uuid?:     string
	constants?: {[string]: number | string}
}

#language_code: =~"^[a-z]{2,4}(-[A-Z][A-Z])?$"
#other_limits:  "memory" | "output" | "code" | "compilation_time" | "compilation_memory" | "validation_time" | "validation_memory" | "validation_output"

#testdata_settings_icpc: output_validator_flags: *"" | string

// Full specification extends the ICPC subset:

#problem_settings: {
	#problem_settings_icpc
	problem_format_version?: !~"icpc"
	validation?:             close({["multipass" | "interactive" | "scoring"]: *false | true})
	keywords?:               string | [...string]
	languages?:              *"all" | [...string]
}

#testdata_settings: {
	#testdata_settings_icpc
	grading?:
		score?: number
	max_score:             number
	aggregation:           "sum" | "min"
	verdict:               "first_error" | "accept_if_any_accepted"
	input_validator_flags: *"" | string | {[string]: string}
}
