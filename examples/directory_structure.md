---
permalink: /examples/directory_structure
---
# Directory structure

```text
<short_name>/
      problem.yaml - problem configuration file
      problem_statement/
              problem.tex - problem statement
              - any files that problem.tex needs to include, e.g. images
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
      submissions/
              accepted/
                - single file or directory per solution
              time_limit_exceeded/
                - single file or directory per solution
              wrong_answer/
                - single file or directory per solution
              run_time_error/
                - single file or directory per solution
      input_validators/
              - single file or directory per validator
      output_validators/
              - single file or directory per validator
```

#### Sample Directory / Filenames

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
├── output_validators
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
