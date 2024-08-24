---
layout: default
title: Legacy
sort: 3
---

# Problem Package Format

This is the `legacy` version of the Kattis problem package format.

## Overview

This document describes the format of a _Kattis problem package_,
used for distributing and sharing problems for algorithmic programming contests as well as educational use.

### General Requirements

- The package must consist of a single directory containing files as described below.
  The directory name must consist solely of lowercase letters a–z and digits 0–9.
  Alternatively, the package can be a ZIP-compressed archive of such a directory with identical base name and extension `.kpp` or `.zip`.
- All file names for files included in the package must match the regexp
  ```regex
  ^[a-zA-Z0-9][a-zA-Z0-9_.-]{0,253}[a-zA-Z0-9]$
  ```
  i.e., they must be of length at least 2, at most 255, consist solely of lower- or uppercase letters a–z, A–Z, digits 0–9, period, dash, or underscore,
  but must not begin or end with a period, dash, or underscore.
- All text files for a problem must be UTF-8 encoded and not have a byte-order mark (BOM).
- All text files must have Unix-style line endings (newline/LF byte only).
  Note that LF is line-ending and not line-separating in POSIX, which means that all non-empty text files must end with a newline.
- Natural language (for example, in the [problem statement](#problem-statements) filename) must be specified as 2-letter [ISO 639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) code if it exists, otherwise as a 3-letter code from ISO 639.
  Optionally, it may be suffixed with a hyphen and an ISO 3166-1 alpha-2 code, as defined in BCP 47, for example, `pt-BR` to indicate Brazilian Portuguese.
- All floating-point numbers must be given as the external character sequences defined by IEEE 754-2008 and may use up to double precision.
- The problem package may include symbolic links to other files in the problem package.
  Symlinks must not have targets outside the problem package directory tree.

### Problem Package Structure Overview

The following table summarizes the elements of a problem package described in this specification:

File or Folder         | Required? | Described In                                  | Description
---------------------- | --------- | --------------------------------------------- | -----------
`problem.yaml`         | Yes       | [Problem Metadata](#problem-metadata)         | Metadata about the problem (e.g., source, license, limits)
`problem_statement/`   | Yes       | [Problem Statements](#problem-statements)     | Problem statement files
`attachments/`         | No        | [Attachments](#attachments)                   | Files available to problem-solvers other than the problem statement and sample test data
`data/sample/`         | No        | [Test Data](#test-data)                       | Sample test data
`data/secret/`         | Yes       | [Test Data](#test-data)                       | Secret test data
`include/`             | No        | [Included Files](#included-files)             | Files appended to all submitted solutions
`submissions/`         | Yes       | [Example Submissions](#example-submissions)   | Correct and incorrect judge solutions of the problem
`input_validators/`    | Yes       | [Input Validators](#input-validators)         | Programs that verifies correctness of the test data inputs
`output_validators/`   | No        | [Output Validators](#output-validators)       | Custom programs for judging solutions

A minimal problem package must contain `problem.yaml`, a problem statement, a secret test case, an accepted judge solution, and an input validator.

### Programs

There are a number of different kinds of programs that may be provided in the problem package: 
submissions, input validators, output validators, and graders.
All programs are always represented by a single file or directory.
In other words, if a program consists of several files, these must be provided in a single directory.
In the case that a program is a single file, it is treated as if a directory with the same name takes its place, which contains only that file.
The name of the program, for the purpose of referring to it within the package, is the base name of the file or the name of the directory.
There can't be two programs of the same kind with the same name.

Validators and graders, but not submissions,
in the form of a directory may include two POSIX-compliant shell scripts, `build` and `run`.
These scripts must be executable when they exist or get generated.
If at least one of these two files is included:

1. First, if the `build` script is present, it will be run.
   The working directory will be (a copy of) the program directory.
   The `run` file must exist after `build` is done.
2. Then, the `run` file (which now exists)
   will be invoked in the same way as a single file program.

Programs without `build` and `run` scripts are built and run according to what language is used.
Language is determined by looking at the file endings as specified in the [languages table](languages.md).
In the case of Python 2 and 3 which share the same file ending,
language will be determined by looking at the shebang line which must match the regular expressions `^#!.*python2` for Python 2 and `^#!.*python3` for Python 3.
If a single language can't be determined, building fails.

For languages where there could be several entry points,
the default entry point in the [languages table](languages.md) will be used.

### Problem Types

There are two types of problems: *pass-fail* problems and *scoring* problems.
In pass-fail problems, submissions are basically judged as either accepted or rejected (though the "rejected" judgement is more fine-grained and divided into results such as "Wrong Answer", "Time Limit Exceeded", etc).
In scoring problems, a submission that is accepted is additionally given a score, which is a numeric value (and the goal is to either maximize or minimize this value).

## Problem Metadata

Metadata about the problem (e.g., source, license, limits) are provided in a YAML file named `problem.yaml` placed in the root directory of the package.

The keys are defined as below.
Keys are optional unless explicitly stated.
Any unknown keys should be treated as an error.

Key                                               | Type                                          | Required  | Default
------------------------------------------------- | --------------------------------------------- | --------- | -------
[problem_format_version](#problem-format-version) | String                                        | No        | `legacy`
[type](#type)                                     | String                                        | No        | `pass-fail`
[name](#name)                                     | String                                        | No        |
[uuid](#uuid)                                     | String                                        | No        |
[author](#author)                                 | String                                        | No        |
[source](#source)                                 | String                                        | No        |
[source_url](#source)                             | String                                        | No        |
[license](#license)                               | String                                        | No        | `unknown`
[rights_owner](#license)                          | String                                        | See below | See below
[limits](#limits)                                 | Map with keys as defined below                | No        | See below
[validation](#validation)                         | String                                        | No        | `default`
[validator_flags](#validation)                    | String                                        | No        |
[scoring](#scoring)                               | Map with keys as defined below                | No        | See below
[keywords](#keywords)                             | String                                        | No        |

### Problem format version

Version of the Problem Package Format used for this package.
If using this version of the Format, it must be the string `legacy` (which is also the default).
Documentation for version `<version>` is available at `https://www.kattis.com/problem-package-format/spec/<version>`.

### Type

Type of problem.
Must be one of `pass-fail` and `scoring`.

### Name

The name of the problem in one of the languages for which a problem statement exists.

### UUID

The `uuid` is meant to track a problem, even if its package name and/or `name` changes.
For example, it can be used to identify the existing problem to update in an online problem archive and not accidentally upload it as a new one.
The intention is that a new `uuid` should be assigned if the problem significantly changes.

This specification currently does not imply any more semantic meaning to this field.

### Author

Who should get author credits.
Given as a string separated by `,` or `and`.
This would typically be the people that came up with the idea, wrote the problem specification and created the test data.
This is sometimes omitted when authors choose to instead only give source credit, but both may be specified.

### Source

Who should get source credit.
This would typically be the name (and year) of the event where the problem was first used or created for.

The `source` key contains the source that this problem originates from.
This should typically contain the name (and year) of the problem set (such as a contest or a course),
where the problem was first used or for which it was created,
and the `source_url` key contains a link to the event's page.
`source_url` must not be given if `source` is not.

### License

License under which the problem may be used.
Must be one of the values below.

Value           | Comments                                                                           | Link
--------------- | ---------------------------------------------------------------------------------- | ----
`unknown`       | The default value. In practice means that the problem can not be used.             |
`public domain` | There are no known copyrights on the problem, anywhere in the world.               | <http://creativecommons.org/about/pdm>
`cc0`           | CC0, "no rights reserved", version 1 or later.                                     | <https://creativecommons.org/publicdomain/zero/1.0/>
`cc by`         | CC attribution license, version 4 or later.                                        | <http://creativecommons.org/licenses/by/4.0/>
`cc by-sa`      | CC attribution, share alike license, version 4 or later.                           | <http://creativecommons.org/licenses/by-sa/4.0/>
`educational`   | May be freely used for educational purposes.                                       |
`permission`    | Used with permission. The rights owner must be contacted for every additional use. |

`rights_owner` is the owner of the copyright of the problem.
Values other than `unknown` or `public domain` require `rights_owner` to have a value.
`rights_owner` defaults to `credits.authors`, if present, otherwise value of `source`.

### Limits

Time, memory, and other limits to be imposed on submissions.
A map with the following keys:

Key                  | Comments                   | Default        | Typical system default
-------------------- | -------------------------- | -------------- | ----------------------
`time_multiplier`    | optional float             | 5              |
`time_safety_margin` | optional float             | 2              |
`memory`             | optional, in MiB           | system default | 2048
`output`             | optional, in MiB           | system default | 8
`code`               | optional, in KiB           | system default | 128
`compilation_time`   | optional, in seconds       | system default | 60
`compilation_memory` | optional, in MiB           | system default | 2048
`validation_time`    | optional, in seconds       | system default | 60
`validation_memory`  | optional, in MiB           | system default | 2048
`validation_output`  | optional, in MiB           | system default | 8

For most keys, the system default will be used if nothing is specified.
This can vary, but you **should** assume that it's reasonable.
Only specify limits when the problem needs a specific limit, but do specify limits even if the "typical system default" is what is needed.

### Validation

`validation` is a space separated list of strings describing how validation is done.
Must begin with one of `default` or `custom`.
If `custom`, may be followed by some subset of `score` and `interactive`,
where `score` indicates that the validator produces a score (this is only valid for scoring problems),
and `interactive` specifies that the validator is run interactively with a submission.
For example, `custom interactive score`.

`validator_flags` will be passed as command-line arguments to each of the output validators.

### Scoring

Must only be used on scoring problems.
A map with the following keys:

Key                     | Type    | Default | Comments
----------------------- | ------- | ------- | --------
`objective`             | String  | max     | One of "min" or "max" specifying whether it is a minimization or a maximization problem.
`show_test_data_groups` | boolean | false   | Specifies whether test group results should be shown to the end user.

### Keywords

Space separated list of keywords describing the problem.
Keywords must not contain spaces.

## Problem Statements

The problem statement of the problem is provided in the directory `problem_statement/`.

This directory must contain one file per language, for at least one language, named `problem.<language>.<filetype>`,
that contains the problem text itself, including input and output specifications, but not sample input and output.
Language must be given as the shortest ISO 639 code.
If needed, a hyphen and an ISO 3166-1 alpha-2 code may be appended to an ISO 639 code.
Optionally, the language code can be left out; the default is then English (`en`).
Filetype can be either `.tex` for LaTeX files, or `.pdf` for PDF.

Please note that many kinds of transformations on the problem statements,
such as conversion to HTML or styling to fit in a single document containing many problems will not be possible for PDF problem statements,
so using this format should be avoided if at all possible.

Auxiliary files needed by the problem statement files must all be in `problem_statement/`.
`problem.<language>.<filetype>` should reference auxiliary files as if the working directory is `problem_statement/`.
Image file formats supported are `.png`, `.jpg`, `.jpeg`, and `.pdf`.

A LaTeX file may include the Problem name using the LaTeX command `\problemname` in case LaTeX formatting of the title is wanted.

The problem statements must only contain the actual problem statement, no sample data.

## Attachments

Public, i.e., non-secret, files to be made available in addition to the problem statement and sample test data are provided in the directory `attachments/`.

## Test data

The test data are provided in subdirectories of `data/`.
The sample data in `data/sample/` and the secret data in `data/secret/`.

All input and answer files have the filename extension `.in` and `.ans` respectively.

### Annotations

One hint, description, and/or illustration file may be provided per test case.
The files must share the base name of the associated test case.
Description and illustration files are meant to be privileged information.

Category     | File type | Filename extension                 | Remark
------------ | --------- | ---------------------------------- | ------
hint         | text      | `.hint`                            |
description  | text      | `.desc`                            | privileged information
illustration | image     | `.png`, `.jpg`, `.jpeg`, or `.svg` | privileged information

- A *hint* provides feedback for solving a test case to, e.g., somebody whose submission didn't pass.

- A *description* conveys the purpose of a test case.
  It is an explanation of what aspect or edge case of the solution that the input file is meant to test.

- An *illustration* provides a visualization of the associated test case.
  Note that at most one image file may exist for each test case.

### Interactive Problems

Unlike in non-interactive problems, `.in` and `.ans` files in interactive problems **must not** be displayed to teams:
not in the problem statement, nor as part of sample input download.
Instead, all sample test cases **must** provide an interaction protocol as a text file with the extension `.interaction` demonstrating the communication between the submission and the output validator, meant to be displayed in the problem statement.

Additional sample interaction protocols may be defined by creating an `.interaction` file without corresponding `.in` and `.ans` files.

An interaction protocol consists of a series of lines starting with `>` and `<`.
Lines starting with `>` signify an output from the submission to the output validator,
while those starting with `<` signify an input from the output validator to the submission.

If you want to provide files related to interactive problems (such as testing tools or input files), you can use [attachments](#attachments).

### Test Data Groups

The test data for the problem can be organized into a tree-like structure.
Each node of this tree is represented by a directory and referred to as a test data group.
Each test data group may consist of zero or more test cases (i.e., input-answer files) and zero or more subgroups of test data (i.e., subdirectories).

At the top level, the test data is divided into exactly two groups: `sample` and `secret`.
These two groups may be further split into subgroups as desired.

The *result* of a test data group is computed by applying a *grader* to all of the sub-results (test cases and subgroups) in the group.
See [Graders](#graders) for more details.

Test cases and groups will be used in lexicographical order on file base name.
If a specific order is desired, a numbered prefix such as `00`, `01`, `02`, `03`, and so on, can be used.

In each test data group, a YAML file `testdata.yaml` may be placed to specify how the result of the test data group should be computed.
If a test data group has no `testdata.yaml` file, the `testdata.yaml` in the closest ancestor group that has one will be used.
If there is no `testdata.yaml` file in the root `data` group, one is implicitly added with the default values.

The format of `testdata.yaml` is as follows:

Key                      | Type                                           | Default      | Comments
------------------------ | ---------------------------------------------- | ------------ | --------
`on_reject`              | String                                         | break        | One of "break" or "continue". Specifies how judging should proceed when a submission gets a non-Accept judgement on an individual test case or subgroup. If "break", judging proceeds immediately to grading. If "continue", judging continues judging the rest of the test cases and subgroups within the group.
`grading`                | String                                         | default      | One of "default" and "custom".
`grader_flags`           | String                                         | empty string | arguments passed to the grader for this test data group.
`input_validator_flags`  | String or map with the keys "name" and "flags" | empty string | arguments passed to the input validator for this test data group. If a string, then those are the arguments that will be passed to each input validator for this test data group. If a map, then this is the name of the input validator as well as the arguments to pass to that input validator for this test data group. Validators not present in the map are run without any arguments.
`output_validator_flags` | String or map with the keys "name" and "flags" | empty string | arguments passed to the output validator for this test data group. If a string, this is the name of the output validator that will be used for this test data group. If a map, then this is the name as well as the arguments that will be passed to the output validator.
`accept_score`           | String                                         | 1            | Default score for accepted input files. May only be specified for scoring problems.
`reject_score`           | String                                         | 0            | Default score for rejected input files. May only be specified for scoring problems.
`range`                  | String                                         | \-inf +inf   | Two numbers A and B ("inf", "-inf", "+inf" are allowed for plus/minus infinity) specifying the range of possible scores. May only be specified for scoring problems.

## Included Code

Code that should be included with all submissions are provided in one directory per supported language, called `include/<language>/`.

The files should be copied from a language directory based on the language of the submission,
to the submission files before compiling,
overwriting files from the submission in the case of name collision.
Language must be given as one of the language codes in the language table in the overview section.
If any of the included files are supposed to be the main file (i.e., a driver),
that file must have the language-dependent name as given in the table referred above.

## Example Submissions

Correct and incorrect solutions to the problem are provided in subdirectories of `submissions/`.
The possible subdirectories are:

Value                 | Requirement                                                                                                                        | Comment
--------------------- | ---------------------------------------------------------------------------------------------------------------------------------- | -------
`accepted`            | Accepted as a correct solution for all test cases.                                                                                 | At least one is required.
`partially_accepted`  | Overall verdict must be Accepted. Overall score must not be max of range if objective is max and min of range if objective is min. | Must not be used for pass-fail problems.
`wrong_answer`        | Wrong answer for some test case, but is not too slow and does not crash for any test case.                                         |
`time_limit_exceeded` | Too slow for some test case. May also give wrong answer but not crash for any test case.                                           |
`run_time_error`      | Crashes for some test case.                                                                                                        |

Every file or directory in these directories represents a separate solution.
It is mandatory to provide at least one accepted solution.

Submissions must read input data from standard input, and write output to standard output.

## Input Validators

Input Validators, verifying the correctness of the input files, are provided in `input_validators/` (or the deprecated `input_format_validators/`).
Input validators can be specified as [VIVA](http://viva.vanb.org/)-files (with file ending `.viva`),
[Checktestdata](https://github.com/DOMjudge/checktestdata)-file (with file ending `.ctd`),
or as a program.

All input validators provided will be run on every input file.
Validation fails if any validator fails.

### Invocation

An input validator program must be an application (executable or interpreted) capable of being invoked with a command line call.

All input validators provided will be run on every test data file using the arguments specified for the test data group they are part of.
Validation fails if any validator fails.

When invoked, the input validator will get the input file on stdin.

The validator should be possible to use as follows on the command line:
```sh
<input_validator_program> [arguments] < inputfile
```

### Output

The input validator may output debug information on stdout and stderr.
This information may be displayed to the user upon invocation of the validator.

### Exit codes

The input validator must exit with code 42 on successful validation.
Any other exit code means that the input file could not be confirmed as valid.

#### Dependencies

The validator **must not** read any files outside those defined in the Invocation section.
Its result **must** depend only on these files and the arguments.

## Output Validators

### Overview

An output validator is a [program](#programs) that is given the output of a submitted program,
together with the corresponding input file,
and an answer file for the input,
and then decides whether the output provided is a correct output for the given input file.

A validator program must be an application (executable or interpreted) capable of being invoked with a command line call.
The details of this invocation are described below.
The validator program has two ways of reporting back the results of validating:

1.  The validator must give a judgement (see [Reporting a judgement](#reporting-a-judgement)).
2.  The validator may give additional feedback,
    e.g., an explanation of the judgement to humans (see [Reporting Additional Feedback](#reporting-additional-feedback)).

Custom output validators are used if the problem requires more complicated output validation than what is provided by the default diff variant described below.
They are provided in `output_validators/`, and must adhere to the [Output validator](#output-validators) specification.

All output validators provided will be run on the output for every test data file using the arguments specified for the test data group they are part of.
Validation fails if any validator fails.

### Default Output Validator Specification

The default output validator is essentially a beefed-up diff.
In its default mode, it tokenizes the output and answer files and compares them token by token.
It supports the following command-line arguments to control how tokens are compared.

Arguments                    | Description
---------------------------- | -----------
`case_sensitive`             | indicates that comparisons should be case-sensitive.
`space_change_sensitive`     | indicates that changes in the amount of whitespace should be rejected (the default is that any sequence of 1 or more whitespace characters are equivalent).
`float_relative_tolerance ε` | indicates that floating-point tokens should be accepted if they are within relative error ≤ ε (see below for details).
`float_absolute_tolerance ε` | indicates that floating-point tokens should be accepted if they are within absolute error ≤ ε (see below for details).
`float_tolerance ε`          | short-hand for applying ε as both relative and absolute tolerance.

When supplying both a relative and an absolute tolerance, the semantics are that a token is accepted if it is within either of the two tolerances.
When a floating-point tolerance has been set, any valid formatting of floating-point numbers is accepted for floating-point tokens.
So, for instance, if a token in the answer file says `0.0314`, a token of `3.14000000e-2` in the output file would be accepted.
If no floating-point tolerance has been set, floating-point tokens are treated just like any other token and have to match exactly.

### Invocation

When invoked the output validator will be passed at least three command line parameters and the output stream to validate on stdin.

The validator should be possible to use as follows on the command line:
```sh
<output_validator_program> input answer_file feedback_dir [additional_arguments] < team_output [ > team_input ]
```

The meaning of the parameters listed above are:

- input:
  a string specifying the name of the input data file that was used to test the program whose results are being validated.
- answer_file:
  a string specifying the name of an arbitrary "answer file" which acts as input to the validator program.
  The answer file may, but is not necessarily required to, contain the "correct answer" for the problem.
  For example, it might contain the output that was produced by a judge's solution for the problem when run with input file as input.
  Alternatively, the "answer file" might contain information, in arbitrary format, which instructs the validator in some way about how to accomplish its task.
- feedback_dir:
  a string which specifies the name of a "feedback directory" in which the validator can produce "feedback files" in order to report additional information on the validation of the output file.
  The feedbackdir must end with a path separator (typically '/' or '\\' depending on operating system),
  so that simply appending a filename to feedbackdir gives the path to a file in the feedback directory.
- additional_arguments:
  in case the problem specifies additional `validator_flags`, these are passed as additional arguments to the validator on the command line.
- team_output:
  the output produced by the program being validated is given on the validator's standard input pipe.
- team_input:
  when running the validator in interactive mode everything written on the validator's standard output pipe is given to the program being validated.
  Please note that when running interactive the program will only receive the output produced by the validator and will not have direct access to the input file.

The two files pointed to by input and answer_file must exist (though they are allowed to be empty) and the validator program must be allowed to open them for reading.
The directory pointed to by feedback_dir must also exist.

### Reporting a judgement

A validator program is required to report its judgement by exiting with specific exit codes:

- If the output is a correct output for the input file (i.e., the submission that produced the output is to be Accepted),
  the validator exits with exit code 42.
- If the output is incorrect (i.e., the submission that produced the output is to be judged as Wrong Answer),
  the validator exits with exit code 43.

Any other exit code (including 0\!) indicates that the validator did not operate properly,
and the judging system invoking the validator must take measures to report this to contest personnel.
The purpose of these somewhat exotic exit codes is to avoid conflict with other exit codes that results when the validator crashes.
For instance, if the validator is written in Java, any unhandled exception results in the program crashing with an exit code of 1,
making it unsuitable to assign a judgement meaning to this exit code.

### Reporting Additional Feedback

The purpose of the feedback directory is to allow the validator program to report more information to the judging system than just the accept/reject verdict.
Using the feedback directory is optional for a validator program, so if one just wants to write a bare-bones minimal validator, it can be ignored.

The validator is free to create different files in the feedback directory,
in order to provide different kinds of information to the judging system, in a simple but organized way.
For instance, there may be a `judgemessage.txt` file,
the contents of which gives a message that is presented to a judge reviewing the current submission
(typically used to help the judge verify why the submission was judged as incorrect, by specifying exactly what was wrong with its output).
Other examples of files that may be useful in some contexts (though not in the ICPC) are a `score.txt` file,
giving the submission a score based on other factors than correctness,
or a `teammessage.txt` file, giving a message to the team that submitted the solution, providing additional feedback on the submission.

A judging system that implements this format must support the `judgemessage.txt` file described above
(I.e., content of the `judgemessage.txt` file, if produced by the validator, must be provided by the judging system to a human judge examining the submission).
Having the judging system support other files is optional.

Note that a validator may choose to ignore the feedback directory entirely.
In particular, the judging system must not assume that the validator program creates any files there at all.

#### Examples

An example of a `judgemessage.txt` file:
```text
Team failed at test case 14.
Team output: "31", Judge answer: "30".
Team failed at test case 18.
Team output: "hovercraft", Judge answer: "7".
Summary: 2 test cases failed.
```

An example of a `teammessage.txt` file:
```text
Almost all test cases failed — are you even trying to solve the problem?
```

#### Validator standard error

A validator program is allowed to write any kind of debug information to its standard error pipe.
This information may be displayed to the user upon invocation of the validator.

## Graders

Graders are programs that are given the sub-results of a test data group and aggregate a result for the group.
They are provided in `graders/`.

For pass-fail problems, this grader will typically just set the verdict to accepted if all sub-results in the group were accepted and otherwise select the "worst" error in the group (see below for definition of "worst"),
though it is possible to write a custom grader which e.g. accepts if at least half the sub-results are accepted.
For scoring problems, one common grader behaviour would be to always set the verdict to Accepted,
with the score being the sum of scores of the items in the test group.

### Invocation

A grader program must be an application (executable or interpreted) capable of being invoked with a command line call.

When invoked the grader will get the judgement for test cases or groups on stdin and is expected to produce an aggregate result on stdout.

The grader should be possible to use as follows on the command line:
```sh
<grader_program> [arguments] < judgeresults
```

On success, the grader must exit with exit code 0.

### Input

A grader simply takes a list of results on standard input, and produces a single result on standard output.
The input file will have the one line per test case containing the result of judging the testfile,
using the code from the table below, followed by whitespace, followed by the score.

Code | Meaning
---- | -------
AC   | Accepted
WA   | Wrong Answer
RTE  | Run-Time Error
TLE  | Time-Limit Exceeded

The score is taken from the `score.txt` files produced by the output validator.
If no `score.txt` exists the score will be as defined by the grading accept_score and reject_score setting from `problem.yaml`.

### Output

The grader must output the aggregate result on stdout in the same format as its input.
Any other output, including no output, will result in a Judging Error.

For pass-fail problems, or for non-Accepted results on scoring problems, the score provided by the grader will always be ignored.

The grader may output debug information on stderr.
This information may be displayed to the user upon invocation of the grader.

### Default Grader Specification

The default grader has three different modes for aggregating the verdict
-- _worst_error_, _first_error_ and _always_accept_ --
four different modes for aggregating the score
-- _sum_, _avg_, _min_, _max_ --
and two flags
-- _ignore_sample_ and _accept_if_any_accepted_.
These modes can be set by providing their names as command line arguments (through the "grader_flags" option in [`testdata.yaml`](#test-data-groups)).
If multiple conflicting modes are given, the last one is used. Their meaning are as follows.

Argument                 | Type         | Description
------------------------ | ------------ | -----------
`worst_error`            | verdict mode | Default. Verdict is accepted if all sub-results are accepted, otherwise it is the first of JE, IF, RTE, MLE, TLE, OLE, WA that is the sub-result of some item in the test case group. Note that in combination with the on_reject:break policy in `testdata.yaml`, the result will be the first error encountered.
`first_error`            | verdict mode | Verdict is accepted if all sub-results are accepted, otherwise it is the verdict of the first sub-result with a non-accepted verdict. Please note `worst_error` and `first_error` always give the same result if `on_reject` is set to `break`, and as such it is recommended to use the default.
`always_accept`          | verdict mode | Verdict is always accepted.
`sum`                    | scoring mode | Default. Score is sum of input scores.
`avg`                    | scoring mode | score is average of input scores.
`min`                    | scoring mode | score is minimum of input scores.
`max`                    | scoring mode | score is maximum of input scores.
`ignore_sample`          | flag         | Must only be used on the root level. The first sub-result (sample) will be ignored, the second sub-result (secret) will be used, both verdict and score.
`accept_if_any_accepted` | flag         | Verdict is accepted if any sub-result is accepted, otherwise as specified by the verdict aggregation mode.
