---
layout: page
lang: fr
ref: learn_basics_loops
---

# Boucles

## Boucles conditionnelles

Une boucle `while` va tourner tant qu'une condition est vraie :

```ocaml
let i = ref 10 in
while !i > 0 do
    print_endline "Hello world";
    i := !i - 1
done;;
```

## Boucles inconditionnelles

Une boucle `for` va tourner pour un certain ensemble de valeurs :

```ocaml
for k = 1 to 10 do
    print_endline ("Hello world " ^ (string_of_int k));
done;;
```
