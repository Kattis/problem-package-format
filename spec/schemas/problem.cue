import "strings"

#problem_settings: {
    name: string | { [#language_code]: string }
    type?: *"pass-fail" | "scoring"
    author?: string
    source?: string
    if source != _|_ { source_url?: string } // only allow source_url if source is specified
    license?: *"unknown" | "public domain" | "cc0" | "cc by" | "cc by-sa" | "educational" | "permission"
    rights_owner?: string
    limits?: #limits
    validation?: *"default" | #custom_validation
    validator_flags?: *"" |  string
    keywords?: string | [...string]
    uuid?: string
    languages?: *"all" | [...string]
}

// The problem's (natural) language code is ISO 639, 
// optionally followed by ISO 3166-1 alpha-2 
#language_code: =~ "^[a-z][a-z](-[A-Z][A-Z])?$" 

#custom_validation: this={
    string
    _as_struct: { for w in strings.Split(this, " ")  { (w): _ } }
    _as_struct: close({ 
        custom: _,       // Must include "custom",
        score?: _,       // can include "score" ...
        interactive?: _  // ... and "interactive"
})
}

#limits: { 
    time_multiplier?: *5 | >0
    time_safety_margin?: *2 | >0
    memory?: int
    output?: int
    code?: int
    compilation_time?: int
    compilation_memory?: int
    validation_time?: int
    validation_memory?: int
    validation_output?: int
}
