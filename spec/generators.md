---
sort: 3
---

# Generators

Generators are provided in the `generators/` directory and may be used to
generate test cases.  If it is present, the file `generators/generators.yaml`
specifies which testcases should be generated and which commands should be run
to generate them.
Please have a look at [**the generator examples**](../examples/generators.yaml) to quickly get a feeling of what a typical `generators.yaml` file looks like.

When `generators/generators.yaml` is present, _all_ test cases in
`data/{sample,secret}` must be mentioned by it. It is not allowed to generate
some testcases while not mentioning others. Testcases must be explicitly
listed as manually created to prevent this issue.

Below are an explanation of the specification and a formal [CUE specification](#cue-specification).

## Specification

The three main object types are **Directory**, **Generator** and **Command**. The root of `generators.yaml` is a **Root Directory** which corresponds to the `data/` directory.

Unknown keys are allowed and ignored.

### **Directory**

A **Directory** is a YAML dictionary with the following supported keys.

* `type`
    * Type: String
    * Mandatory, **must** be set to `directory`.
* `data`
    * Type: (List of) dictionary mapping string to either **Directory** or **Generator**
    * The test cases / test groups contained in this directory.
      This may take one of two forms:
        1.  A dictionary, where each key is the name of a test case/test group, and each value must be a **Directory** or **Generator**. _All names must be distinct, as required by the YAML specification._
        1. A list of such dictionaries. In this case, testcases will be prefixed with zero padded 1-based integers in the order of the list. Items in the same dictionary will get the same number.
* `solution`
    * Type: **Command**
    * Optional invocation of a solution to be used to generate `.ans` files in this directory and its children.
      Set to empty to disable generating `.ans`.
      (Useful for e.g. the `data/samples/` directory.)
      This must be an absolute path relative to the problem root.

      Solutions must write the answer to standard output, or take the `{name}` argument and write the answer file directly.
* `visualizer`
    * Type: **Command**
    * Optional invocation of a visualizer to generate visualizations for each test case in this directory and its children.
      This must be an absolute path relative to the problem root. Set to empty to disable.

       _Visualizers should take the `{name}` argument and write to `{name}.ext` where `ext` is a supported image extension._
* `testdata.yaml`
    * Type: YAML object
    * Optional configuration that will be copied to `testdata.yaml` in this directory.
* `random_salt`
    * Type: String
    * Optional string that will be prepended to each command before computing its `{seed}`.
      May be used to regenerate all random cases and to prevent predictable seeds.

### **Root directory**
The root of the `generators.yaml` file is a **Directory** object with one optional additional key:

* `generators`
    * Type: dictionary mapping string to list of string.
    * A dictionary mapping generator names to a list of dependencies.
      This must be used when using non-directory generators that depend on other files in the `generators/` directory. Each key of the dictionary is the name of a generator, and values must be lists of file paths relative to `generators/`.

      When this dictionary contains a name that is also a file in `generators/`, the version specified in the `generators` dictionary will have priority.

      Generators specified in the `generators` dictionary are built by coping the list of files into a new directory, and then building the resulting program as usual. The first dependency listed will be used to determine the entry point.
      An example is [here](../examples/generators.yaml).

      Other generators are built as (file or directory) [programs](../spec/Problem_Format#Programs).

### **Generator**

A **Generator** takes one of the following four types/forms:

1. Null / empty
    * An empty generator means that the testcase is a manual case and must not be modified or deleted by generator tooling. The corresponding `.in` file must be present in the `data/` directory. The corresponding `.ans` may be present, but may also be generated once from a given solution. Note that this form is discouraged. Prefer specifying a path to a `.in` file as below.
1. String ending with `.in`
    * A path to a `.in` file which must be relative to `generators/`. The `.in` file and corresponding files with known extensions will be copied to the specified location. If a `.ans` is not specified and a `solution` is provided, it will be used to generate the `.ans`.
1. String not ending with `.in`,
    * A **Command** to run a generator.
1. Directory containing `type: testcase`
    * The `input` key is the **Command** to use. Furthermore, the dictionary may contain the `solution`, `visualizer`, and `random_salt` keys similar to a **Directory** to specialize/override them for this testcase only.

### **Command**

A **Command** is a string that specified how to invoke a generator. The form is:
```
<generator_name> <arguments>
```
Generators are run from an unspecified working directory. _In particular, they must not assume that the working directory is either the directory of the target testcase (e.g. `data/secret`) or the directory of the program (e.g. `visualizers/my_visualizer/`)._

Generators must be deterministic, i.e. always produce the same input file when give the same arguments.

Generators must be idempotent, i.e. running them multiple times should result in the same output as running them once.

* `<generator_name>` must either be a program (file/directory) in `generators/` or else a key in the top level `generators` dictionary.
* The generator will be invoked with `<arguments>`.
  Arguments are separated by white space (space, tab, newline). Quoting white space is not supported.
  Two special values are available, that will be substituted before calling the generator.
    * `{name}`: refers to the name of the testcase. The generator may read/write the files `{name}.<ext>`, where `<ext>` is a file extension recognised by the problem format. Reading or writing other files is not allowed.

      _Note that `{name}` does not have to be in the currently working directory,
      and may not be inside the `data/` directory._
    * `{seed}` or `{seed:(0-9)+}`: will be replaced by a pseudo random seed deterministically generated from the generator invocation. Use `{seed:1}`, `{seed:2}`, ..., to use different seeds for multiple otherwise identical generator invocations.

## CUE specification.

Below is a formal [CUE](https://cuelang.org/docs/references/spec/) specification for the `generators.yaml` file with a root object `Generators`. Note that the `...` in `generator` and `directory` indicate that additional keys unknown to the spec are allowed. The `generator_reserved` and `directory_reserved` objects indicate keys that work only for `generator`/`directory` and should not be reused in other places.

```
command :: !="" & (=~"^[^{}]*(\\{(name|seed(:[0-9]+)?)\\}[^{}]*)*$")
file_config :: {
    solution?: command | null
    visualizer?: command | null
    random_salt?: string
}
generator :: command | {
    type: "testcase"
    input: command
    file_config
    directory_reserved
    ...
}
data_dict :: {
    [string]: directory | generator | null
}
directory :: {
    type: "directory"
    file_config
    "testdata.yaml"?: {
        ...
    }
    data?: data_dict | [...data_dict]
    generator_reserved
    ...
}
Generators :: {
    generators?: {
        [string]: [...string]
    }
    directory
}

generator_reserved :: {
    input?: _|_
    ...
}
directory_reserved :: {
    data?: _|_
    include?: _|_
    "testdata.yaml"?: _|_
    ...
}
```

