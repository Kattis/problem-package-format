#problem_settings_base: {
	name:                    string | close({[#language_code]: string})
	problem_format_version?: *"legacy" | "draft" | =~"^[0-9]{4}-[0-9]{2}(-draft)?$"
	type?:                   *"pass-fail" | "scoring"

	author?:     string
	source?:     string
	source_url?: string // only allow if source exists

    license?:  *"unknown" | "public domain" | #license_with_rights
    rights_owner?: string
    if rights_owner != _|_ { license?: #license_with_rights }

	limits?: {
		time_multiplier?: {
			ac_to_time_limit:  *2.0 | number 
			time_limit_to_tle: *1.5 | number 
		}
		time_limit?:      number & >0
		time_resolution?: *1.0 | number
		[#other_limits]:  int
	}
	validation?: [string]: *false | true
	keywords?: string | [...string]
	uuid?:     string
	constants?: {[string]: number | string}
}

#license_with_rights: "cc0" | "cc by" | "cc by-sa" | "educational" | "permission"

#problem_settings_icpc: {
    #problem_settings_base
    type?: "pass-fail"
	validation?: close({ interactive: _ })
}

#problem_settings: {
	#problem_settings_base
	keywords?:   string | [...string]
    validation?: close({["multipass" | "interactive" | "scoring"]: _})
    if validation.scoring != _|_ { type: "scoring" }
	languages?:  *"all" | [...string]
}

#language_code: =~"^[a-z]{2,4}(-[A-Z][A-Z])?$"
#other_limits:  "memory" | "output" | "code" | "compilation_time" | "compilation_memory" | "validation_time" | "validation_memory" | "validation_output"

#testdata_settings_icpc: output_validator_flags: *"" | string

#testdata_settings: {
	#testdata_settings_icpc
	grading?: {
		score?:               number
		max_score?:           number
		score_aggregation?:   "sum" | "min"
		verdict_aggregation?: "first_error" | "accept_if_any_accepted"
	}
	input_validator_flags: *"" | string | {[string]: string}
}