---
layout: default
permalink: /spec/problem_package_format
sort: 1
show_diff_buttons: true
---
# Problem Package Format

<div class="problemarchive">

Sections <s>highlighted in yellow</s> have not been
implemented in the reference implementation of the problem format tool
chain. This might imply that that part of the specification is more in
flux. Sections <s class="dep">highlighted in red</s> are deprecated.
</div>

## Overview

This document describes the format of a *Kattis problem package*, used
for distributing and sharing problems for algorithmic programming
contests as well as educational use.

### General Requirements

The package consists of a single directory containing files as described
below, or alternatively, a ZIP compressed archive of the same files
using the file extension `.kpp` . The name of the directory or the base
name of the archive must consisting solely of lower case letters a-z and
digits 0-9.

All file names for files included in the package must match the
following regexp

`[a-zA-Z0-9][a-zA-Z0-9_.-]*[a-zA-Z0-9]`

I.e., it must be of length at least 2, consist solely of lower or upper
case letters a-z, A-Z, digits 0-9, period, dash or underscore, but must
not begin or end with period, dash or underscore.

All text files for a problem must be UTF-8 encoded and not have a byte
order mark.

All floating point numbers must be given as the external character
sequences defined by IEEE 754-2008 and may use up to double precision.

### Programs

There are a number of different kinds of programs that may be provided
in the problem package; submissions, input validators, output
validators<s class="problemarchive">, graders and generators</s>.
All programs are always represented by a single file or directory. In other
words, if a program consists of several files, these must be provided in a
single directory. The name of the program, for the purpose of referring to it
within the package is the base name of the file or the name of the directory.
There can't be two programs of the same kind with the same name.

Validators and graders, but not submissions, in the form of a directory
may include two POSIX-compliant scripts "build" and "run". Either both
or none of these scripts must be included. If the scripts are present,
then:

  - the program will be compiled by executing the build script.
  - the program will be run by executing the run script.

Programs without build and run scripts are built and run according to
what language is used. Language is determined by looking at the file
endings. If a single language from the table below can't be determined,
building fails. In the case of Python 2 and 3 which share the same file
ending, language will be determined by looking at the shebang line which
must match the regular expressions in the table below.

For languages where there could be several entry points, the default
entry point in the table below will be used.


| Code       | Language    | Default entry point | File endings              | Shebang                                                                                      |
| - | - | - | - | - |
| c          | C           |                     | .c                        |                                                                                              |
| cpp        | C++         |                     | .cc, .cpp, .cxx, .c++, .C |                                                                                              |
| csharp     | C\#         |                     | .cs                       |                                                                                              |
| go         | Go          |                     | .go                       |                                                                                              |
| haskell    | Haskell     |                     | .hs                       |                                                                                              |
| java       | Java        | Main                | .java                     |                                                                                              |
| javascript | JavaScript  | main.js             | .js                       |                                                                                              |
| kotlin     | Kotlin      | MainKt              | .kt                       |                                                                                              |
| lisp       | Common Lisp | main.{lisp,cl}      | .lisp, .cl                 |                                                                                              |
| objectivec | Objective-C |                     | .m                        |                                                                                              |
| ocaml      | OCaml       |                     | .ml                     |                                                                                              |
| pascal     | Pascal      |                     | .pas                      |                                                                                              |
| php        | PHP         | main.php            | .php                      |                                                                                              |
| prolog     | Prolog      |                     | .pl                       |                                                                                              |
| python2    | Python 2    | main.py             | .py                       | Matches the regex "`^#!.*python2`", and default if shebang does not match any other language |
| python3    | Python 3    | main.py             | .py                       | Matches the regex "`^#!.*python3`"                                                           |
| ruby       | Ruby        |                     | .rb                       |                                                                                              |
| rust       | Rust        |                     | .rs                       |                                                                                              |
| scala      | Scala       |                     | .scala                    |                                                                                              |


<div class="problemarchive">

### Problem types


There are two types of problems: <em>pass-fail</em> problems and
<em>scoring</em> problems. In pass-fail problems, submissions are
basically judged as either accepted or rejected (though the "rejected"
judgement is more fine-grained and divided into results such as "Wrong
Answer", "Time Limit Exceeded", etc). In scoring problems, a submission
that is accepted is additionally given a score, which is a numeric value
(and the goal is to either maximize or minimize this value).

</div>

## Problem Metadata

Metadata about the problem (e.g., source, license, limits) are provided
in a UTF-8 encoded YAML file named `problem.yaml` placed in the root
directory of the package.

The keys are defined as below. Keys are optional unless explicitly
stated. Any unknown keys should be treated as an error.


| Key                                       | Type                                 | Default                                                 | Comments                                                                                                                                                                                                                                                                                                                                       |
| - | - | - | - |
| <s class="problemarchive"> <s>name</s>                               </s> | <s class="problemarchive"> <s>String or map of strings</s>      </s> | <s class="problemarchive">                                                         </s> | <s class="problemarchive"> <s>Required. If a string this is the name of the problem in english. If a map the keys are language codes and the values are the name of the problem in that language. It is an error for a language to be missing if there exists a problem statement for that language.</s>                                                                  </s> |
| <s class="problemarchive"> type                                      </s> | <s class="problemarchive"> String                               </s> | <s class="problemarchive"> pass-fail                                               </s> | <s class="problemarchive"> One of "pass-fail" and "scoring".                                                                                                                                                                                                                                                                                                              </s> |
| author                                    | String                               |                                                         | Who should get author credits. This would typically be the people that came up with the idea, wrote the problem specification and created the test data. This is sometimes omitted when authors choose to instead only give source credit, but both may be specified.                                                                          |
| source                                    | String                               |                                                         | Who should get source credit. This would typically be the name (and year) of the event where the problem was first used or created for.                                                                                                                                                                                                        |
| source\_url                               | String                               |                                                         | Link to page for source event. Must not be given if source is not.                                                                                                                                                                                                                                                                             |
| license                                   | String                               | unknown                                                 | License under which the problem may be used. Value has to be one of the ones defined below.                                                                                                                                                                                                                                                    |
| rights\_owner                             | String                               | Value of author, if present, otherwise value of source. | Owner of the copyright of the problem. If not present, author is owner. If author is not present either, source is owner. Required if license is something other than "unknown" or "public domain". Forbidden if license is "public domain".                                                                                                   |
| limits                                    | Map with keys as defined below       | see definition below                                    |                                                                                                                                                                                                                                                                                                                                                |
| validation                                |  String                              |  default                                                |  One of "default" or "custom". If "custom", may be followed by <s class="problemarchive">some subset of "score" and</s> "interactive", where<s class="problemarchive"> "score" indicates that the validator produces a score (this is only valid for scoring problems), and</s> "interactive" specifies that the validator is run interactively with a submission. For example, "custom interactive<s class="problemarchive"> score</s>". |
| validator\_flags                          | String                               |                                                         | Will be passed as command-line arguments to each of the output validators.                                                                                                                                                                                                                                                                     |
| <s class="problemarchive"> <s class="dep">grading</s> <s>scoring</s> </s> | <s class="problemarchive"> Map with keys as defined below       </s> | <s class="problemarchive"> See definition below                                    </s> | <s class="problemarchive"> Must only be used on scoring problems.                                                                                                                                                                                                                                                                                                         </s> |
|  keywords                                   |  <s>String or sequence of strings</s>  |                                                           |  Set of keywords. |
|  <s>uuid</s>                                |  <s>String</s>                         |                                                           |  <s>UUID identifying the problem.</s>                                                                                                                                                                                                                                                                                                            |
| <s class="problemarchive"> <s>libraries</s>                          </s> | <s class="problemarchive"> <s>String or sequence of strings</s> </s> | <s class="problemarchive">                                                         </s> | <s class="problemarchive"> <s>Set of libraries as defined below.</s>                                                                                                                                                                                                                                                                                                      </s> |
| <s class="problemarchive"> <s>languages</s>                          </s> | <s class="problemarchive"> <s>String or sequence of strings</s> </s> | <s class="problemarchive"> <s>all</s>                                              </s> | <s class="problemarchive"> <s>Set of languages or "all".</s>                                                                                                                                                                                                                                                                                                              </s> |

```note

TODO: Further discussion over the `name` key is needed.
```

### license

Allowed values for license.

Values other than *unknown* or *public domain* requires rights\_owner to
have a value.

| Value         | Comments                                                                     | Link                                             |
| - | - | - |
| unknown       | The default value. In practice means that the problem can not be used.       |                                                  |
| public domain | There are no known copyrights on the problem, anywhere in the world.         | <http://creativecommons.org/about/pdm>           |
| cc0           | CC0, "no rights reserved"                                                    | <http://creativecommons.org/about/cc0>           |
| cc by         | CC attribution                                                               | <http://creativecommons.org/licenses/by/3.0/>    |
| cc by-sa      | CC attribution, share alike                                                  | <http://creativecommons.org/licenses/by-sa/3.0/> |
| educational   | May be freely used for educational purposes                                  |                                                  |
| permission    | Used with permission. The author must be contacted for every additional use. |                                                  |

### limits

A map with the following keys:

| Key                  | Comments             | Default        | Typical system default |
| - | - | - | - |
| time\_multiplier     | optional             | 5              |                        |
| time\_safety\_margin | optional             | 2              |                        |
| memory               | optional, in MiB     | system default | 2048                   |
| output               | optional, in MiB     | system default | 8                      |
| code                 | optional, in kiB     | system default | 128                    |
| compilation\_time    | optional, in seconds | system default | 60                     |
| compilation\_memory  | optional, in MiB     | system default | 2048                   |
| validation\_time     | optional, in seconds | system default | 60                     |
| validation\_memory   | optional, in MiB     | system default | 2048                   |
| validation\_output   | optional, in MiB     | system default | 8                      |

For most keys the system default will be used if nothing is specified.
This can vary, but you SHOULD assume that it's reasonable. Only specify
limits when the problem needs a specific limit, but do specify limits
even if the "typical system default" is what is needed.

<div class="problemarchive">

### <s class="dep">grading</s> <s>scoring</s>

A map with the following keys:

</div>
<div class="problemarchive">

| Key                      | Type    | Default | Comments                                                                                 |
| - | - | - | - |
| objective                | String  | max     | One of "min" or "max" specifying whether it is a minimization or a maximization problem. |
| show\_test\_data\_groups | boolean | false   | Specifies whether test group results should be shown to the end user.                    |
|                          |         |         |                                                                                          |

</div>
<div class="problemarchive">


### libraries

<s> A set from elements below. A library will be available for the
languages listed. </s>

</div>
<div class="problemarchive">

| Value | Library                                             | Languages |
| - | - | - |
| gmp   | GMP - The GNU Multiple Precision Arithmetic Library | C, C++    |
| boost | Boost                                               | C++       |

</div>
<div class="problemarchive">


### languages

<s>

A space separated list of language code from the table in the
overview section or *all*.

If a list is given, the problem may only be solved using those
languages.

</s>

</div>

## Problem Statements

The problem statement of the problem is provided in the directory
`problem_statement/`.

This directory must contain one file per language, for at least one
language, named `problem.`<language>`.`<filetype>, that contains the
problem text itself, including input and output specifications, but not
sample input and output. Language must be given as the
shortest ISO 639 code. If needed a hyphen and a ISO 3166-1 alpha-2 code
may be appended to ISO 639 code. Optionally, the language code can
be left out, the default is then English (`en`). Filetype can be either
`tex` for LaTeX files<s>, `md` for Markdown,</s><s class='problemarchive'><s> or `pdf` for PDF</s></s>.

```note

TODO: More discussion is needed over allowing PDF in the CLICS spec.
```

<div class="problemarchive">

Please note that many kinds of transformations on the problem
statements, such as conversion to HTML or styling to fit in a single
document containing many problems will not be possible for PDF problem
statements, so using this format should be avoided if at all possible.

</div>

Auxiliary files needed by the problem statement files must all be in
`<short_name>/problem_statement/`. `problem.<language>.<filetype>`
should reference auxiliary files as if the working directory is
`<short_name>/problem_statement/`. Image file formats supported are
`.png`, `.jpg`, `.jpeg`, and `.pdf`.


A LaTeX file may include the Problem name using the LaTeX command
`\problemname` in case LaTeX formatting of the title is wanted.
<s class="problemarchive"><s>If
it's not included the problem name specified in `problem.yaml` will be
used.</s> </s>

The problem statements must only contain the actual problem statement,
no sample data.

## Attachments

Public, i.e. non-secret, files to be made available in addition to the
problem statement and sample test data are provided in the directory
`attachments/`.

## Test data

<div class="problemarchive">

<s>

If input generators are used the files described here might not be
available in this directory. This section describes what must be the
case after running the generators.

</s>

</div>
The test data are provided in subdirectories of `data/`. The sample data
in `data/sample/` and the secret data in `data/secret/`.

All input and answer files have the filename extension `.in` and `.ans`
respectively.

### Annotations

Optionally a hint, a description and an illustration file may be
provided.

The hint file is a text file with filename extension`.hint` giving a
hint for solving an input file. The hint file is meant to be given as
feedback, i.e. to somebody that fails to solve the problem.

The description file is a text file with filename extension `.desc`
describing the purpose of an input file. The description file is meant
to be privileged information that explains the purpose of the related
test file, e.g. what cases it's supposed to test.

The Illustration is an image file with filename extension `.png`,
`.jpg`, `.jpeg`, or `.svg`. The illustration is meant to be privileged
information illustrating the related test file.

Input, answer, description, hint and image files are matched by the base
name.

### Test Data Groups

<s class="problemarchive">

The test data for the problem can be organized into a tree-like
structure. Each node of this tree is represented by a directory and
referred to as a test data group. Each test data group may consist of
zero or more test cases (i.e., input-answer files) and zero or more
subgroups of test data (i.e., subdirectories).

</s>

At the top level, the test data is divided into exactly two groups:
`sample` and `secret`. <s class="problemarchive">These two groups may be further split into subgroups as desired. </s>

<s class="problemarchive">

The <em>result</em> of a test data group is computed by applying a
<em>grader</em> to all of the sub-results (test cases and subgroups) in
the group. See [Graders](#Graders "wikilink") for more details.

</s>

Test files and groups will be used in lexicographical order on file base
name. If a specific order is desired a numbered prefix such as `00`, `01`,
`02`, `03`, and so on, can be used.

<s class="problemarchive">

In each test data group, a file `testdata.yaml` may be placed to specify
how the result of the test data group should be computed. If such a file
is not provided for a test data group then the settings for the parent
group will be used. The format of `testdata.yaml` is as follows:


| Key                                         | Type                                                  | Default      | Comments                                                                                                                                                                                                                                                                                                          |
| - | - | - | - |
| on\_reject                                  | String                                                | break        | One of "break" or "continue". Specifies how judging should proceed when a submission gets a non-Accept judgement on an individual test file or subgroup. If "break", judging proceeds immediately to grading. If "continue", judging continues judging the rest of the test files and subgroups within the group. |
| grading                                     | String                                                | default      | One of "default" and "custom".                                                                                                                                                                                                                                                                                    |
| grader\_flags                               | String                                                | empty string | arguments passed to the grader for this test data group.                                                                                                                                                                                                                                                          |
| input\_validator<s class="dep problemarchive">\_flags</s></s> |  Stringor map with the keys "name" and "flags"</s> |  empty string  | arguments passed to the input validator for this test data group.</s>If a string this is the name of the input validator that will be used for this test data group. If a map then this is the name as well as the flags that will be passed to the input validator.</s>                       |
| output\_validator<s class="dep problemarchive">\_flags</s></s> |  Stringor map with the keys "name" and "flags"</s> |  empty string  | arguments passed to the output validator for this test data group.</s>If a string this is the name of the output validator that will be used for this test data group. If a map then this is the name as well as the flags that will be passed to the output validator.</s>                    |
| accept\_score                               | String                                                | 1            | Default score for accepted input files. May only be specified for scoring problems.                                                                                                                                                                                                                               |
| reject\_score                               | String                                                | 0            | Default score for rejected input files. May only be specified for scoring problems.                                                                                                                                                                                                                               |
| range                                       | String                                                | \-inf +inf   | Two numbers A and B ("inf", "-inf", "+inf" are allowed for plus/minus infinity) specifying the range of possible scores. May only be specified for scoring problems.                                                                                                                                              |

</s>

<div class="problemarchive">


## Included Code

Code that should be included with all submissions are provided in one
directory per supported language, called `include/`<language>`/`.

The files should be copied from a language directory based on the
language of the submission, to the submission files before compiling,
overwriting files from the submission in the case of name collision.
Language must be given as one of the language codes in the language
table in the overview section. If any of the included files are supposed
to be the main file (i.e. a driver), that file must have the language
dependent name as given in the table referred above.
</div>

## Example Submissions

Correct and incorrect solutions to the problem are provided in
subdirectories of `submissions/`. The possible subdirectories are:


| Value                 | Requirement                                                                                                                        | Comment                                  |
| - | - | - |
| `accepted`              | Accepted as a correct solution for all test files                                                                                  | At least one is required.                |
| <s class="problemarchive"> partially\_accepted   </s> | <s class="problemarchive"> Overall verdict must be Accepted. Overall score must not be max of range if objective is max and min of range if objective is min. </s> | <s class="problemarchive"> Must not be used for pass-fail problems. </s> |
| `wrong_answer`         | Wrong answer for some test file, but is not too slow and does not crash for any test file                                          |                                          |
| `time_limit_exceeded` | Too slow for some test file. May also give wrong answer but not crash for any test file.                                           |                                          |
| `run_time_error`      | Crashes for some test file                                                                                                         |                                          |
| `mixed_result` | The submission contains `@EXPECTED_RESULTS@:` with expected verdicts, as explained below. | Use when the result is not deterministic. |

```todo
`mixed` vs `multiple` and `result` vs `verdict`.
```

<div class="problemarchive">

<s>

For submissions of type `accepted` and scoring problems, the expected
score can be specified by including the string `@EXPECTED_SCORE@:`
followed by the expected score somewhere in the source code, e.g. in a
comment.

</s>

</div>

Every file or directory in these directories represents a separate
solution. Same requirements as for submissions with regards to
filenames. It is mandatory to provide at least one accepted solution.

Submissions must read input data from standard input, and write output
to standard output.

### EXPECTED_RESULTS

Submissions in the `submissions/mixed_result` directory must contain an
`@EXPECTED_RESULTS@: ` tag (including the final space) exactly once in one
of their source files. This must be followed (on the same line) by a non-empty
comma separated subset of:

- `ACCEPTED`
- `WRONG_ANSWER`
- `RUN_TIME_ERROR` 
- `TIME_LIMIT_EXCEEDED` 
- <s class="problemarchive"><s>`PARTIALLY_ACCEPTED` (for scoring problems only).</s></s>

Additional white space is ignored and the tags are not case sensitive.

This tag implies that the submission may get any of the listed verdicts as
final verdict. Single testcases may still result in a verdict not in the list.
In particular `ACCEPTED` does not have to be listed unless the submission is
allowed to pass *all* testcases.

If `@EXPECTED_RESULTS@: ` is found in a submission in any of the other
directories, a warning is raised when the directory verdict is not listed. Note
that this does not have other other effect, and in particular only the
directory verdict is an allowed.


## Input Validators

Input Validators, for verifying the correctness of the input files, are
provided in <s class="dep problemarchive">`input_format_validators/`</s>
<s>`input_validators/`</s>. Input validators can be specified as
VIVA-files (with file ending `.viva`), Checktestdata-file (with file
ending `.ctd`), or as a program.

All input validators provided will be run on every input file.
Validation fails if any validator fails.

### Invocation

An input validator program must be an application (executable or
interpreted) capable of being invoked with a command line call.

All input validators provided will be run on every test data file using
the arguments specified for the test data group they are part of.
Validation fails if any validator fails.

When invoked the input validator will get the input file on stdin.

The validator should be possible to use as follows on the command line:

`./validator [arguments] < inputfile`

### Output

The input validator may output debug information on stdout and stderr.
This information may be displayed to the user upon invocation of the
validator.

### Exit codes

The input validator must exit with code 42 on successful validation. Any
other exit code means that the input file could not be confirmed as
valid.

#### Dependencies

The validator MUST NOT read any files outside those defined in the
Invocation section. Its result MUST depend only on these files and the
arguments.

## Output Validators

Output Validators are used if the problem requires more complicated
output validation than what is provided by the default diff variant
described below. They are provided in `output_validators/`, and must
adhere to the [Output validator](Output_validator "wikilink")
specification.

All output validators provided will be run on the output for every test
data file using the arguments specified for the test data group they are
part of. Validation fails if any validator fails.

### Default Output Validator Specification

The default output validator is essentially a beefed-up diff. In its
default mode, it tokenizes the files to compare and compares them token
by token. It supports the following command-line arguments to control
how tokens are compared.

| Arguments                    | Description                                                                                                                                                 |
| - | - |
| `case_sensitive`             | indicates that comparisons should be case-sensitive.                                                                                                        |
| `space_change_sensitive`     | indicates that changes in the amount of whitespace should be rejected (the default is that any sequence of 1 or more whitespace characters are equivalent). |
| `float_relative_tolerance ε` | indicates that floating-point tokens should be accepted if they are within relative error ≤ ε (see below for details).                                      |
| `float_absolute_tolerance ε` | indicates that floating-point tokens should be accepted if they are within absolute error ≤ ε (see below for details).                                      |
| `float_tolerance ε`          | short-hand for applying ε as both relative and absolute tolerance.                                                                                          |

When supplying both a relative and an absolute tolerance, the semantics
are that a token is accepted if it is within either of the two
tolerances. When a floating-point tolerance has been set, any valid
formatting of floating point numbers is accepted for floating point
tokens. So for instance if a token in the answer file says `0.0314`, a
token of `3.14000000e-2` in the output file would be accepted. If no
floating point tolerance has been set, floating point tokens are treated
just like any other token and has to match exactly.

<div class="problemarchive">

## Graders

Graders are programs that are given the sub-results of a test data group
and aggregate a result for the group. They are provided in `graders/` .

For pass-fail problems, this grader will typically just set the verdict
to accepted if all sub-results in the group were accepted and otherwise
select the "worst" error in the group (see below for definition of
"worst"), though it is possible to write a custom grader which e.g.
accepts if at least half the sub-results are accepted. For scoring
problems, one common grader behaviour would be to always set the verdict
to Accepted, with the score being the sum of scores of the items in the
test group.

### Invocation

A grader program must be an application (executable or interpreted)
capable of being invoked with a command line call.

When invoked the grader will get the judgement for test files or groups
on stdin and is expected to produce an aggregate result on stdout.

The grader should be possible to use as follows on the command line:

`./grader [arguments] < judgeresults`

On success, the grader must exit with exit code 0.

### Input

A grader simply takes a list of results on standard input, and produces
a single result on standard output. The input file will have the one
line per test file containing the result of judging the testfile, using
the code from the table below, followed by whitespace, followed by the
score. <s>Format to be extended.</s>

</div>
<div class="problemarchive">

| Code | Meaning             |
| - | - |
| AC   | Accepted            |
| WA   | Wrong Answer        |
| RTE  | Run-Time Error      |
| TLE  | Time-Limit Exceeded |

</div>
<div class="problemarchive">


The score is taken from the `score.txt` files produced by the ouput
validator. If no `score.txt` exists the score will be as defined by the
grading accept\_score and reject\_score setting from problem.yaml.

### Output

The grader must output the aggregate result on stdout in the same format
as its input. Any other output, including no output, will result in a
Judging Error.

For pass-fail problems, or for non-Accepted results on scoring problems,
the score provided by the grader will always be ignored.

The grader may output debug information on stderr. This information may
be displayed to the user upon invocation of the grader.

### Default Grader Specification

The default grader has three different modes for aggregating the verdict
-- *worst\_error*, *first\_error* and *always\_accept* -- four different
modes for aggregating the score -- *sum*, *avg*, *min*, *max* -- and two
flags -- *ignore\_sample* and *accept\_if\_any\_accepted*. These modes
can be set by providing their names as command line arguments (through
the "grader\_flags" option in
[testdata.yaml](#Test_Data_Groups "wikilink")). If multiple conflicting
modes are given, the last one is used. Their meaning are as follows.

</div>
<div class="problemarchive">

| Argument                                     | Type         | Description                                                                                                                                                                                                                                                                                                     |
| - | - | - |
| `worst_error` <s class="dep">`no_errors`</s> | verdict mode | Default. Verdict is accepted if all subresults are accepted, otherwise it is the first of JE, IF, RTE, MLE, TLE, OLE, WA that is the subresult of some item in the test case group. Note that in combination with the on\_reject:break policy in testdata.yaml, the result will be the first error encountered. |
| `first_error`                                | verdict mode | Verdict is accepted if all subresults are accepted, otherwise it is the verdict of the first subresult with a non-accepted verdict. Please note `worst_error` and `first_error` always give the same result if `on_reject` is set to `break`, and as such it is recommended to use the default.                 |
| `always_accept`                              | verdict mode | Verdict is always accepted.                                                                                                                                                                                                                                                                                     |
| `sum`                                        | scoring mode | Default. Score is sum of input scores.                                                                                                                                                                                                                                                                          |
| `avg`                                        | scoring mode | score is average of input scores.                                                                                                                                                                                                                                                                               |
| `min`                                        | scoring mode | score is minimum of input scores.                                                                                                                                                                                                                                                                               |
| `max`                                        | scoring mode | score is maximum of input scores.                                                                                                                                                                                                                                                                               |
| `ignore_sample`                              | flag         | Must only be used on the root level. The first subresult (sample) will be ignored, the second subresult (secret) will be used, both verdict and score.                                                                                                                                                          |
| `accept_if_any_accepted`                     | flag         | Verdict is accepted if any subresult is accepted, otherwise as specified by the verdict aggregation mode.                                                                                                                                                                                                       |
</div>
<div class="problemarchive">


## <s>Generators</s>

<s>

Input generators are programs that generates input. They are
provided in `generators/`.

```note

TODO: Add the new `generators.yaml` specification.
```

</s>

### <s>Invocation</s>

<s>

A generator program must be an application (executable or
interpreted) capable of being invoked with a command line call.

The generators will be run with the test data directory (`data/`) as the
working directory. The generator may read any existing files in that
directory and should create any kind of test data file as defined in the
test data section. The generator may not read or write anything outside
the test data directory. The generators will be run in lexicographical
order on name. If a specific order is desired a numbered prefix such as
`00`, `01`, `02`, `03`, and so on, can be used.

The generators must be deterministic, i.e. always produce the same input
file when give the same arguments.

The generators must be idempotent, i.e. running them multiple times
should result in the same contents of the test data directory as running
them once.

</s>
</div>

## See also

  - [Output validator](Output_validator "wikilink")
  - [Sample problem.yaml](Sample_problem.yaml "wikilink")
  - [Problem format directory
    structure](Problem_format_directory_structure "wikilink")
  - [Problem Format
    Verification](Problem_Format_Verification "wikilink")
