# Problem package format style guide

This document defines the formatting and writing style conventions for the Kattis problem package format specification documents.

## Purpose

This style guide ensures consistency across all specification documents and makes diffs more useful when reviewing changes.

## Markdown formatting

### Text emphasis

- Use `_` for _italics_
- Use `**` for **bold** text

### Tables

Tables should be formatted with the following conventions:

- No prefix `|` at the beginning of rows
- No postfix `|` at the end of rows  
- Exactly one space between `---` and `|` in the header divider row on each side
- Match width of columns for all rows (that is, all columns are as wide as the largest content), except when that becomes unreasonable
- Match width of columns between format versions when "the same" table exist in both, to allow useful diffs
- Last header divider matches the length of the header text, not the content below

**Example:**
```markdown
Key        | Type  | Default | Comments
---------- | ----- | ------- | --------
time_limit | float | auto    | Time limit in seconds
memory     | int   | 2048    | Memory limit in MiB
```

### Line breaks and paragraphs

Add newlines to make diffs maximally useful:

- Add a newline after every sentence
- Add newlines at subclauses (after commas) when the sentence becomes too long **and** it makes semantic sense

## Language and terminology

### Latin abbreviations

Use full English phrases instead of Latin abbreviations for clarity:

- Write "for example" instead of "e.g."
- Write "that is" instead of "i.e."
- Write "and so on" instead of "etc."

**Rationale:** This is clearer for non-native English speakers and those without Latin knowledge, and helps avoid formatting issues.

### Headers and capitalization

Capitalize headers like normal sentences (sentence case), 
that is, only capitalize the first word and proper nouns.

**Examples:**
- ✅ "Problem metadata"
- ✅ "Test data groups" 
- ✅ "LaTeX environment and supported subset"
- ❌ "Problem Metadata"
- ❌ "Test Data Groups"

## Implementation guidelines

### When making changes

- Apply these style conventions when making content changes
- Separate stylistic changes from content changes as much as reasonably possible
- Focus on consistency within the section being modified
- When in doubt, prioritize diff clarity over perfect formatting
- Style can always be fixed in a follow up PR

### Review process

- Reviewers should check for adherence to these style guidelines
- Style consistency is important but should not block substantive improvements

## Rationale

These conventions were chosen to:

1. **Minimize line length** - Important for tables that cannot be line-broken
2. **Maximize diff usefulness** - Changes should be easy to review
3. **Improve readability** - Especially for non-native English speakers
4. **Ensure consistency** - Across all specification versions and documents
5. **Facilitate maintenance** - Clear conventions reduce decision fatigue

## Examples

### Good table formatting

```markdown
Extension | Description                   | Required
--------- | ----------------------------- | --------
.in       | Input piped to standard input | Yes
.ans      | Answer file for validator     | Yes
.files    | Input available via file I/O  | No
```

### Good sentence structure

```markdown
The validator should be possible to use as follows on the command line:

```
<input_validator_program> [arguments] < inputfile
```

Here, `arguments` is the `input_validator_args`.
```

### Good header hierarchy

```markdown
## Problem statements

### Sample data

#### Samples for judging team submissions

The `data/sample` directory contains test cases similar to those in `data/secret`.
```

---

*This style guide is a living document and may be updated based on community feedback and evolving needs.*
