---
layout: page
lang: en
ref: learn_basics_pattern_matching
---

# Pattern matching

## Pattern matching

Pattern matching allows to match something with different cases:

```ocaml
let i = 10 in
let name = match i with
| 1 -> "1st"
| 2 -> "2nd"
| 3 -> "3rd"
| _ -> (string_of_int i) ^ "th"
in print_string name;;
```

In this example, we match the value of i with different patterns: if i matches 1, it returns 1st, … and the last case, represented by a `_` matches everything else (it is a default case). Note that every possible value should be associated with a case in the pattern matching: it has to be exhaustive.

## Match using 'when' keyword

The `when` keyword allows to add a condition to a case:

```ocaml
let i = 10 in
let p = match i with
| n when n mod 2 = 0 -> "Even"
| _ -> "Odd"
in print_string p;;
```
