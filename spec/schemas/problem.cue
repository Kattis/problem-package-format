import "strings"

#problem_settings: {
    name: string | { [#language_code]: string }
    problem_format_version?: *"legacy" | "draft" | =~ "\d\d\d\d-\d\d(-draft)?"
    type?: *"pass-fail" | "scoring"
    author?: string
    source?: string
    if source != _|_ { source_url?: string } // only allow source_url if source is specified
    license?: *"unknown" | "public domain" | "cc0" | "cc by" | "cc by-sa" | "educational" | "permission"
    rights_owner?: string
    limits?: #limits
    validation?: *"default" | "custom" | "interactive" | "score" | "interactive score"
    keywords?: string | [...string]
    uuid?: string
    languages?: *"all" | [...string]
}

// The problem's (natural) language code is ISO 639, 
// optionally followed by ISO 3166-1 alpha-2 
#language_code: =~ "^[a-z]{2,4}(-[A-Z][A-Z])?$" 

#limits: { 
    time_multiplier?: {
        accepted_to_limit: *2.0 | float
        limit_to_exceeded: *1.5 | float
     }
    time_limit?: >0
    time_resolution?: *1.0 | float
    memory?: int
    output?: int
    code?: int
    compilation_time?: int
    compilation_memory?: int
    validation_time?: int
    validation_memory?: int
    validation_output?: int
}