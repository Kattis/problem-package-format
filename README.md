---
title: Main page
sort: 1
---

# Problem Package Format Specification

This site contains the specification for the Kattis Problem Package Format.
There are currently three versions:

- The latest (draft) version: <https://www.kattis.com/problem-package-format/spec/2023-07-draft.html>.
- The current version: <https://www.kattis.com/problem-package-format/spec/legacy.html>.
- The ICPC subset of the current version: <https://icpc.io/problem-package-format/spec/legacy-icpc.html>.

The latest (draft) version is not yet widely supported, 
but if you're building tools and systems you should definitely take a look at it. 
If you're creating problems for official ICPC contests you should not assume more than the ICPC subset without talking to your technical staff.

Development happens in the GitHub repository: <https://github.com/Kattis/problem-package-format>.
Contrubutions and comments are very welcome!

## System support

This is an (incomplete?) list of systems supporting Problem Package Format:

- [problemtools](https://github.com/kattis/problemtools):
  This is the reference validation tool for the Kattis format. 
  It is not intended to be more than that.
- [BAPCtools](https://github.com/RagnarGrootKoerkamp/BAPCtools):
  Development tool for creating and developing problems using the Kattis format.
- [Testdata Tools](https://github.com/Kodsport/testdata_tools):
  Bash helper functions for working with problems for the Kattis format, particularly ones that use multiple test groups.
- [Kattis](https://open.kattis.com/):
  Online Judge.
- [DOMjudge](https://www.domjudge.org/):
  Judging system.
- [PC^2](https://pc2ccs.github.io/):
  Judging system.
- [ICPC Problem Archive](https://github.com/icpc-problem-archive):
  Archive of all problems from official ICPC contests.

If you have a system that supports or uses the problem package format and want it included here, please make a pull request or an issue on this repository.
