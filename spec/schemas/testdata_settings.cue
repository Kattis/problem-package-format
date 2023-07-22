package problemformat

import "strings"
import "strconv"

#filename: =~ "^[a-zA-Z0-9][a-zA-Z0-9_.-]*[a-zA-Z0-9]$" // make these shorter?
#path: =~ "[a-zA-Z0-9_.-/]*"

#testdata_settings: {
	on_reject: *"break" | "continue"
	grading: *"default" | "custom"
	grader_flags:  *"" | string
    if grading == "default" { grader_flags? : #default_grader_flags }
	input_validator_flags: *"" | string
	output_validator_flags: *"" |string
	accept_score: *"1" | #score
	reject_score: *"0" | #score
	range: *"-inf +inf" | string
    // Verify that the range make sense:
    // a) It should be a space-separated pair of scores
    _range_list: strings.Split(range, " ") & [string, string]
    _lo: _range_list[0] & (#score | "-inf")
    _hi: _range_list[1] & (#score | "inf" | "+inf")
    _lo_val: strconv.ParseFloat(_lo, 64) & <= strconv.ParseFloat(_hi, 64)
}
// matches "1", "06", "21", ".4", "-1.2", but not 'inf'
#score: =~ "^-?([0-9]+|[0-9]*.[0-9]+)$"

// Default grader
// --------------

#default_grader_flags: this={
    string  
    _as_struct: { for w in strings.Split(this, " ")  { (w): _ } }  // convert to struct and ...
    _as_struct: #valid_default_grader_fields                       // ... validate its fields
    }

// Default grader flags (converted to fields of a CUE struct for validation)
#valid_default_grader_fields: {
    #verdict_aggregation_mode?   // at most one verdict aggregation mode
    #score_aggregation_mode?     // at most one score aggregation mode
    ignore_sample?: _            // two more optional flags
    accept_if_any_accepted?: _
}

#verdict_aggregation_mode: {first_error: _ } | *{worst_error: _  } | {always_accept: _ }
#score_aggregation_mode:  {min: _ } | {max: _ } | *{sum: _ } | {avg: _ }