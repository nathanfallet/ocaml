---
layout: page
lang: en
ref: learn_basics_variables
---

# Variables

## Local and global variable definition

A variable is a location in memory where you can store a value. Here is how a variable is created in OCaml:

```ocaml
let x = 3;;
```

The `let` keyword indicates that we define a variable. Then follow the name of the variable, `x`, which is set to a value, `3`. The variable is defined globally (it is accessible from everywhere) and is immutable (its value cannot be changed)

A variable can also be defined locally:

```ocaml
(* We define a local x variable *)
let x = 3 in
x + 4;;

(* Here we have an error *)
x + 4;;
```

In the first expression, we define a variable, x, available in everything following the `in` keyword, until a `;;` is reached. So `x + 4` evaluates to `7`. However, in the second expression, x is not defined, because it was declared locally in the other expression. So we will have an error.

## Variable types

There are different types of variables in OCaml. In the previous example, x was an integer, known as the `int` type. Here are basic types of variables available in OCaml:

```ocaml
let x = 3;; (* int *)
let y = 3.0;; (* float *)
let test = true;; (* bool *)
let txt = "Hello";; (* string *)
let a = 'a';; (* char *)
let empty = ();; (* unit *)
```

`int` and `float` types represent integrers and floating point numbers.

`bool` represents boolean values, true or false.

`string` represents string, a succession of characters.

`char` represents a single character.

Note that a character is defined with single quotes, while a string is defined with double quotes.

Finally, `unit` is the type representing nothing.

## Declare references (mutable variables)

We can declare mutable variables, called references:

```ocaml
let x = ref 3;;
```

Here, x is not containing the value 3, but a reference to the value 3. That way, we can change the value that x points to, which is not possible with a classic variable. References can be useful for loops where you need to increment a value for each round, for example.

```ocaml
let x = ref 3;;
x := 4;; (* 1 *)
x;; (* 2 *)
!x;; (* 3 *)
```

The statement 1 set the value of the reference to 4. Note the usage of `:=` instead of `=` to set the value to the reference instead of the value to the variable (which won't work). The statement 2 returns the reference (of type `int ref`), while the statement 3 returns the value of the reference (here `4`, of type `int`).
