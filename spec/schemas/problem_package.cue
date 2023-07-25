import "strings"

#problem_settings: {
	name:                    string | close({[#language_code]: string})
	problem_format_version?: *"legacy" | "draft" | =~"[0-9-]+(-draft)?"
	type?:                   *"pass-fail" | "scoring"
	author?:                 string
	source?:                 string
	if source != _|_ {source_url?: string} // only allow source_url if source is specified

	license?: *"unknown" | "public domain" | "cc0" | "cc by" | "cc by-sa" | "educational" | "permission"
	if license != "public domain" {rights_owner?: string}

	// TODO (CUE version > 0.5.0)
	// if license =~ "unknown|public domain" {
	//    numexists(>=1, rights_owner, author, source)
	//} 
	limits?:     #limits
	validation?: *"default" | "custom" | {["multipass" | "interactive" | "scoring"]: *false | true}
	keywords?:   string | [...string]
	uuid?:       string
	languages?:  *"all" | [...string]
	constants?: {[string]: number | string}
}

// The problem's (natural) language code in ISO 639, 
// optionally followed by ISO 3166-1 alpha-2 
#language_code: =~"^[a-z]{2,4}(-[A-Z][A-Z])?$"

#limits: {
	time_multiplier?: {
		ac_to_time_limit:  *2.0 | float
		time_limit_to_tle: *1.5 | float
	}
	time_limit?:      >0
	time_resolution?: *1.0 | float
	["memory" |
		"output" |
		"code" |
		"compilation_time" |
		"compilation_memory" |
		"validation_time" |
		"validation_memory" |
		"validation_output",
	]: "int"
}

#testdata_settings: {
	grading?:
		score?: number
	max_score:              number
	aggregation:            "sum" | "min"
	verdict:                "first_error" | "accept_if_any_accepted"
	input_validator_flags:  *"" | string | {[string]: string}
	output_validator_flags: *"" | string
}
