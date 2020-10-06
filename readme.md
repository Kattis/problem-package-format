---
title: Main page
sort: 1
---
# Quick Introduction to the Kattis Problem Format

```note

TODO: Rewrite this page and explain differences between CLICS and Kattis specs.
```

This document is a quick introduction to writing problems for the Kattis
Problem Format and using Kattis Problem Tools. For more thorough
documentation about the Kattis Problem Format, please refer to
\[Problem\_Format\]. For more information about the Kattis Problem
Tools, please refer to <https://github.com/Kattis/problemtools>

## Example Problems

To start with, it probably helps to see some examples. Here's a set of
problems that are written in the format:
<http://ncpc.idi.ntnu.no/ncpc2015/ncpc2015all.tar.bz2> (Warning: 22+ MB
download.) These were the ones used for NCPC 2015. You can see how they
appear on Kattis in HTML here: <https://ncpc15.kattis.com/problems>

## Kattis Problem Tools

Here is the source to the Kattis problemtools:
<https://github.com/Kattis/problemtools> You can install these on Ubuntu
(see the README on that page). The three key programs you need from this
are `verifyproblem`, `problem2pdf`, and `problem2html`.

### verifyproblem

Verifyproblem will do something like the following:

  - check that the problem statement can be compiled (from LaTeX)
  - check that there's at least one input format validator and one
    accepted submission
  - run input format validators on all inputs
  - run all submissions (accepted and otherwise) on the inputs and check
    that the results match the expectation
  - run any output validators if they exist on output produced by the
    submissions
  - compute time limits based on a time multiplier times the slowest
    accepted submission

## Kattis Problem Format

Here's extensive documentation on the problem format:
\[Problem\_Format\] Note that some sections are deprecated and some are
not yet implemented (but are marked as such).

### Typical Problem Format Layout

The problem format is a directory with a top-level file `problem.yaml`
and a number of subdirectories (and sub-subdirectories). Here are some
of the common things that are expected:

#### Test Data

  - `data/sample/{a.in, a.ans}` -- required; sample input file,
    corresponding answer file -- these are automatically placed into the
    problem statement

<!-- end list -->

  - `data/secret/{a.in, a.ans}` -- required; secret corresponding input
    / answer files

NB: Kattis runs all sample AND secret test cases with each submission,
so no need to include an extra copy of the samples in the secret
directory

NB: the order of tests is the file sort order of the file names (all
samples before all secrets)

#### Validators

  - `input_format_validators/` -- required; contain program(s) which
    must accept each input file NB: the definition of an input validator
    accepting is exiting with exit code 42

<!-- end list -->

  - `output_validators/` -- typically not used; here you can put
    program(s) which evaluate the correctness of a program's output (if
    the default behavior of comparing with a static file is not
    sufficient)

#### Problem Statement

  - `problem_statement/problem.tex` -- required; the LaTeX file
    describing the problem

#### Submissions (Correct \*\*and\*\* Incorrect)

  - `submissions/accepted/` -- required; contain program(s) which give
    correct output
  - `submissions/time_limit_exceeded/` -- contain program(s) which are
    intended to take too long
  - `submissions/wrong_answer/` -- contain program(s) which are intended
    to finish in time but give incorrect output
  - `submissions/run_time_error/` -- contain program(s) which are
    intended to result in a run-time error during execution (e.g. crash)

#### `problem.yaml`

  - `problem.yaml` -- required; metadata about the problem, such as
    authorship, license, judging flags, etc.

## Using the Problem Format on Kattis Judge

When judging on Kattis, Kattis's default output validator is lenient on
whitespace changing differences, but this can be made strict. Also,
floating-point outputs can be judged to be correct within some specified
tolerance (relative or absolute), which is really nice.
