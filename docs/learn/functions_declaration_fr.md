---
layout: page
lang: fr
ref: learn_functions_declaration
---

# Déclarer une fonction

## Déclarer une fonction

Une fonction est un bloc. Elle peut prendre des arguments, et elle retourne quelque chose. Prenons un exemple pour comprendre comment ça fonctionne :

```ocaml
let multiply a b =
    a * b;;

let n = multiply 3 4;; (* n = 12 *)
```

Dans cet exemple, on créé une fonction appelée `multiply`, avec deux arguments, `a` et `b`. Ensuite, après le `=`, on écrit des instructions pour dire à notre fonction ce qu'elle fait.

Il n'y a pas de mot clé `return` en OCaml : la dernière chose sur la pile est automatiquement retournée par la fonction (et si la pile est vide alors `unit` est retourné). Dans cet exemple, la dernière chose sur la pile est `a * b`, donc le produit des arguments est retourné.

Enfin, on peut appeler une fonction en utilisant son nom, et en passant les arguments après le nom (sans parenthèses).
