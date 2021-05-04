---
layout: page
lang: fr
ref: learn_functions_recursive
---

# Fonctions récursives

## Fonctions récursives

Une fonction récursive est une fonction qui s'appelle elle-même. Le mot clé `rec` doit être ajouté à la déclaration pour que le compileur sache que la fonction est récursive.

```ocaml
let rec factorial n =
    if n = 0 then 1 else n * (factorial (n-1));;
```

C'est un des exemples les plus communs de fonctions récursives : factorielle.

La même fonction peut être écrite en utilisant un filtrage comme ceci :

```ocaml
let rec factorial n =
    match n with
    | 0 -> 1
    | _ -> n * (factorial (n-1));;
```
