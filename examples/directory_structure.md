# Directory structure

These examples are for the latest version of the spec, `2023-07-draft`.

```text
<short_name>/
  problem.yaml - problem configuration file
  problem_statement/
    problem.en.tex - problem statement
    problem.nl.tex - problem statement
    - any files that problem.xy.tex needs to include, e.g. images
  data/
    sample/
      *.in - sample input files
      *.ans - sample answer files
    secret/
      *.in - input files
      *.ans - answer files
      *.hint - optional hint for the team
      *.desc - optional data description
      *.jpg, *.png, *.svg - visualization of the testcase
  include/
    <language>/
      - any files that should be included with all submissions in <language>
    default/
      - any files that should be included with all submissions in any other language
  submissions/
    accepted/
      - a file/directory for each submission with final verdict AC
    time_limit_exceeded/
      - a file/directory for each submission with final verdict TLE
    wrong_answer/
      - a file/directory for each submission with final verdict WA
    run_time_error/
      - a file/directory for each submission with final verdict RTE
  input_validators/
    - single file or directory per validator
  output_validator/
    - a single output validator consisting of one or multiple files
  attachments/
    - public files available to contestants
```

## Example

This is a sample list of directories/files for a problem named `heightprofile`:

```sh
heightprofile
├── problem.yaml
├── problem_statement
│   ├── bike.eps
│   ├── problem.en.tex
│   ├── profile.asy
│   └── profile.pdf
├── data
│   ├── sample
│   │   ├── 1.ans
│   │   ├── 1.in
│   │   ├── 1.png
│   │   ├── 2.ans
│   │   ├── 2.in
│   │   └── 2.png
│   ├── secret
│   │   ├── 01.ans
│   │   ├── 01.desc
│   │   ├── 01.in
│   │   ├── 01.png
│   │   ├── 02.ans
│   │   ├── 02.in
│   │   ├── 02.png
│   │   └── ...
├── input_validators
│   ├── input_validator
│   │   ├── input_validator.cpp
│   │   └── validation.h
│   ├── profile.ctd
│   └── validate.py
├── output_validator
│   └── validate.ctd
└── submissions
    ├── accepted
    │   ├── alex.java
    │   ├── paul.cpp
    │   ├── ragnar.cpp
    │   └── tobi.java
    ├── time_limit_exceeded
    │   ├── jeroen_n2k.java
    │   ├── lukas_n2k.cc
    │   ├── lukas_n2k_sse.cc
    │   ├── lukas_n2k_v2.cc
    │   └── lukas_n2k_v2_sse.cc
    └── wrong_answer
        ├── jeroen_parsingerror.java
        ├── paul-unstable-sort.cpp
        ├── ragnar-2.cpp
        ├── ragnar-4.cpp
        ├── ragnar.cpp
        └── tobi.cpp
```
