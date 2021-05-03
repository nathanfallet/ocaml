---
layout: page
lang: en
ref: learn_basics_operations
---

# Operations on numbers

## Operations on integers

In OCaml, like in any language, we can add, subtract, multiply and divide numbers. `+` is the sum, `-` the difference, `*` the product, `/` the quotient, and `mod` the remainder.

```ocaml
let a = 2 + 3 - 1;; (* a = 4 *)
let b = 7 * 4;; (* b = 28 *)
let c = 7 / 4;; (* c = 1 *)
let d = 7 mod 4;; (* d = 3 *)
```

## Operations on floating point numbers

The same kind of operations can be applied to floating point numbers, but operators are not the same and contain a `.` to indicate that they apply on floating point numbers instead of integers.

```ocaml
let a = 2.7 +. 3.2 -. 0.5;; (* a = 5.4 *)
let b = 1.7 *. 0.2 /. 0.1;; (* b = 3.4 *)
let c = 9.0 **. 0.5;; (* c = 3.0 *)
```

## Usual functions

Usual functions like `sin` are also available in OCaml:

```ocaml
let a = cos 0.0 +. sin 1.0 -. tan 3.14;; (* a = 1.84... *)
let b = asin 1.0 *. acos 1.0 /. atan 1.0;; (* b = 0.0 *)
let c = sinh 2.4;; (* c = 5.46... *)
let d = exp 1.0;; (* d = 2.71... *)
let e = log 2.0;; (* e = 0.69... *)
let f = log10 2.0;; (* f = 0.30... *)
```

## Print numbers to the console

You can print numbers to the console using `print_int` and `print_float`:

```ocaml
let a = 2 + 3 - 1 in
print_int a;;
let b = 2.7 +. 3.2 -. 0.5 in
print_float b;;
```
