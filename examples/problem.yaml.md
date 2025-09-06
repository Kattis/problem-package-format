---
permalink: /examples/problem_yaml
---

# `problem.yaml`

## Minimal

```yaml
problem_format_version: 2025-09
name: Sample problem
uuid: b9f846aa-c233-45ee-a70a-473aecc8fe77
source: ICPC Mid-Atlantic Regional Contest
author: John von Judge
rights_owner: ICPC
```

## Typical

```yaml
problem_format_version: 2025-09
name: Sample problem
uuid: 7594abe6-08e3-4743-8cf9-15c4693cdbf5
author: John von Judge
source: ICPC World Finals 2023
source_url: https://2023.icpc.global
license: cc by-sa
rights_owner: author

validation: custom
```

## Maximal

```yaml
problem_format_version: 2025-09
name:
  en: Sample problem
  nl: Voorbeeld probleem
uuid: 0bf1d986-afc4-4475-a696-3bfca6276b12
# for non-icpc style problems this may also be scoring
type: pass-fail
author: John von Judge
source: ICPC World Finals 2023
source_url: https://2023.icpc.global
license: cc by-sa
rights_owner: ICPC

# shown values are the defaults
limits:
  time_multipliers:
    ac_to_time_limit: 2.0
    time_limit_to_tle: 1.5
  time_limit: 1.0
  time_resolution: 1.0
  memory: 2048
  output: 8
  code: 128
  compilation_time: 60
  compilation_memory: 2048
  validation_time: 60
  validation_memory: 2048
  validation_output: 8

validation: custom

keywords: [graph, dijkstra]

languages: [c, cpp, java, kotlin, python3]
```
