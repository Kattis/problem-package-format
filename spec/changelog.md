---
layout: default
title: Changelog
sort: 1
---

# Changelog

## Version 2023-07-draft

- Removed scoring objective; this now always is "maximize".
- Removed `scoring` keyword from `problem.yaml`.
- Python 3 is now used for `.py` files; for backward compatibility
  `.py2` can still be used for Python 2.
- Clarify various things: sample files for interactive problems,
  `testdata.yaml` inheritance.
- Updated the CC BY-SA license key to mean version 4.0.
- Allow either a build or run script to be present.
- Change specification of time limit multipliers and allow to
  explicitly specify a problem time limit.
- Add a multi-pass problem type.
- Support invalid testdata that validators must fail on.
- Only allow a single output validator, remove `validator_flags` from
  `problem.yaml`, update `{input,output}_validator_flags` in
  `testdata.yaml`.
- Make `name` required and allow a map from language code to name in that language.
- Add `uuid` to `problem.yaml`.
- Add `languages` to `problem.yaml`.
- Add support for Markdown problem statements.
- Change `languages:` and `keywords:` in `problem.yaml` to be lists of strings
  rather than a string of space separated words.
- Clarified when code limit is applied in the case of included code
- Make `uuid` required in `problem.yaml`.

## Legacy version (changes since beginning 2021)

- Removed `libraries` keyword from `problem.yaml`.
- Add specification of `.interaction` files.
- Clarify directory or zip file name.
- Fix typos and broken links.
