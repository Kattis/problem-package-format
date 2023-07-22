---
permalink: /examples/problem_yaml
---
# Problem.yaml

Typical problem.yaml:

```yaml
# Problem configuration
source: ICPC Mid-Atlantic Regional Contest
author: John von Judge 
rights_owner: ICPC
```

Maximal problem.yaml:

```yaml
# Problem configuration
source: ICPC Mid-Atlantic Regional Contest
# Note that a list of strings is not supported.
author:  John von Judge and Jon Judgeson
license: cc by-sa  
rights_owner: ICPC

limits:
   time_multiplier: 5
   time_safety_margin: 2
   memory: 4096  
   output: 16 
   compilation_time: 240
   validation_time: 240
   validation_memory: 3072
   validation_output: 4

validator: space_change_sensitive float_absolute_tolerance 1e-6
```
