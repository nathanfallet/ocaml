---
layout: page
lang: en
ref: learn_basics_conditions
---

# Conditions

## Inline conditions

You can use inline conditions in any expression with an `if … then … else …` statement like this example does:

```ocaml
let a = 7 in
let b = if a > 5 then "++" else "--" in
print_endline b;; (* ++ *)
```

## Multiline conditions

In case you need to execute more than one instruction, you can create multiline conditions too by adding `begin` and `end` keywords.

```ocaml
let a = 7 in
if a > 5 then begin
    let b = "++" in
    print_endline b
end else begin
    let b = "--" in
    print_endline b
end;;
```

## Conditional operators

Classical comparison operators `<`, `>`, `<=` and `>=` are the same as usual. For equality operators, `=` is used for a comparison by value, while `==` is used for a comparison by memory address. The same way, `<>` is the inequality by value and `!=` by memory address.

You can combine condition using logical operators: `&&` for and, `||` for or, and `not` for not.

```ocaml
let a = 7 in
let b = 5 in
let t = if a > b && a - b <> 1 then "ok" else "not ok" in
print_endline t;; (* ok *)
```
