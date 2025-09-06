---
layout: default
title: Directory Structure
sort: 5
---

# Directory structure

These examples are for the latest version of the spec, `2025-09`.

```text
<short_name>/
  problem.yaml - problem configuration file
  statement/
    problem.en.tex - English problem statement as LaTeX
    problem.sv.md - Swedish problem statement as Markdown
    problem.nl.pdf - Dutch problem statement as PDF
    - any files that problem.xy.{tex,md,pdf} needs to include, e.g. images
  attachments/
    - public files available to contestants
  solution/
    solution.en.tex - English problem solution as LaTeX
    solution.sv.md - Swedish problem solution as Markdown
    solution.nl.pdf - Dutch problem solution as PDF
    - any files that solution.xy.{tex,md,pdf} needs to include, e.g. images
  data/
    sample/
      *.in - sample input files
      *.ans - answer files
      *.out - sample output files
      *.interaction - sample interaction protocol files
      *.args - optional command-line arguments
      *.files/
        - any files that should be available to the program when running the current testcase
    secret/(optional_group)/
      *.in - input files
      *.ans - answer files
      *.hint - optional hint for the team
      *.desc - optional data description
      *.{jpg,png,svg} - visualization of the testcase, at most one per testcase
      *.args - optional command-line arguments
      *.files/
        - any files that should be available to the program when running the current testcase
  generators/
    - any generator scripts that were used to generate testcases
  include/
    <language>/
      - any files that should be included with all submissions in <language>
    default/
      - any files that should be included with all submissions in any other language
  submissions/
    submissions.yaml - sample submissions configuration file
    accepted/
      - a file/directory for each submission with verdict AC for all testcases (at least one required)
    rejected /
      - a file/directory for each submission with final verdict other than AC
    wrong_answer/
      - a file/directory for each submission with verdict WA for some testcase
    time_limit_exceeded/
      - a file/directory for each submission with verdict TLE for some testcase
    run_time_error/
      - a file/directory for each submission with verdict RTE for some testcase
    brute_force/
      - a file/directory for each submission with either verdict RTE or TLE for some testcase
  input_validators/
    - a single output validator, either as a .viva file, a .ctd file, or a program.
  input_visualizer/
    - any tools that were used to generate testcases illustrations
  output_validator/
    - a single output validator program.
  output_visualizer/
    - a single output visualizer program.
```

## Example

This is a sample list of directories/files for a problem named `heightprofile`:

```sh
heightprofile
├── problem.yaml
├── statement
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
