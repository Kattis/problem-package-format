package problem_package

#problem_settings: {
	name!:                    string | close({[#language_code]: string})
	problem_format_version?: *"legacy" | "draft" | =~"^[0-9]{4}-[0-9]{2}(-draft)?$"

	author?:       #author_information | [...#author_information]
	source?:       string
	source_url?:   string // only allow if source exists
	license?:      *"unknown" | "public domain" | #license_with_rights
	rights_owner?: string
	if rights_owner != _|_ {license?: #license_with_rights}

	type?:       *"pass-fail" | "scoring"
	validation?: *"default" | "custom" | close({["multipass" | "interactive" | "scoring"]: _})
	limits?: {
		time_multiplier?: {
			ac_to_time_limit?:  *2.0 | number
			time_limit_to_tle?: *1.5 | number
		}
		time_limit?:      number & >0
		time_resolution?: *1.0 | number
		[#other_limits]:  int
	}
	constants?: {[=~"^[a-z0-9]+$"]: number | string}
	keywords?: string | [...string]
	uuid!: =~"^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$"
	keywords?: string | [...string]
	if validation.scoring != _|_ {type: "scoring"}
	languages?: *"all" | [...string]
}

#problem_settings

#author_information : string | {
	name!: string
	email?: string
}
#license_with_rights: "cc0" | "cc by" | "cc by-sa" | "educational" | "permission"
#language_code:       =~"^[a-z]{2,4}(-[A-Z][A-Z])?$"
#other_limits:        "memory" | "output" | "code" | "compilation_time" | "compilation_memory" | "validation_time" | "validation_memory" | "validation_output"
