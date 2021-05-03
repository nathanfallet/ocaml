---
layout: page
lang: en
ref: learn_functions_recursive
---

# Recursive functions

## Recursive functions

A recursive function is a function calling itself again and again. The keyword `rec` should be added to the declaration to let the compiler know that the function is recursive.

```ocaml
let rec factorial n =
    if n = 0 then 1 else n * (factorial (n-1));;
```

This is one of the most common example of recursive function: factorial.

The same function can be written using pattern matching like this:

```ocaml
let rec factorial n =
    match n with
    | 0 -> 1
    | _ -> n * (factorial (n-1));;
```
