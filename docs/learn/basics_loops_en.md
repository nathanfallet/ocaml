---
layout: page
lang: en
ref: learn_basics_loops
---

# Loops

## Conditional loops

A `while` loop will run while a condition is true:

```ocaml
let i = ref 10 in
while !i > 0 do
    print_endline "Hello world";
    i := !i - 1
done;;
```

## Unconditional loops

A `for` loop will run for a fixed set of values:

```ocaml
for k = 1 to 10 do
    print_endline ("Hello world " ^ (string_of_int k));
done;;
```
