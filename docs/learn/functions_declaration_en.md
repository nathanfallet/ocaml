---
layout: page
lang: en
ref: learn_functions_declaration
---

# Declare a function

## Declare a function

A function is a block. It can take arguments, and it returns a something. Let's see an example to understand how it works:

```ocaml
let multiply a b =
    a * b;;

let n = multiply 3 4;; (* n = 12 *)
```

In this example, we create a function called `multiply`, with two arguments, `a` and `b`. Then, after the `=`, we write instructions to tell to our function what it does.

There is no `return` keyword in OCaml: the last thing on the stack is automatically returned by the function (and if the stack is empty then `unit` is returned). In this example, the last thing on the stack is `a * b`, so the product of both arguments is returned.

Finally, we can call a function by using its name, and passing arguments after the name (without paranthesis).
