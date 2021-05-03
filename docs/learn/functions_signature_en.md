---
layout: page
lang: en
ref: learn_functions_signature
---

# Function signatures

## Function signatures

Let's take back our 'multiply' function to see what's a signature:

```ocaml
let multiply a b =
    a * b;;
```

Here, the signature of the function is `int -> int -> int`. It corresponds, from left to right, to argument types and return type, separated by arrows.

The signature is automatically determined by the compiler, depending on what the function does with arguments. In our example, we multiply both arguments using the `*` operator, so the only possible signature is the one we have. If we write the same function using `*.`, we will have another signature: `float -> float -> float`, because `*.` is defined for floats.
