---
layout: page
lang: fr
ref: learn_functions_signature
---

# Signatures de fonctions

## Signatures de fonctions

Reprenons notre exemple de la fonction `multiply` pour voir ce qu'est une signature :

```ocaml
let multiply a b =
    a * b;;
```

Ici, la signature de la fonction est `int -> int -> int`. Ça correspond, de gauche à droite, aux types des arguments, et du type retourné, séparés par des flèches.

La signature est automatiquement déterminée par le compileur en fonction de ce que la fonction fait avec les arguments. Dans notre exemple, on multiplie les deux arguments en utilisant l'opérateur `*`, donc la seule signature possible est celle que l'on a. Si on avait écrit la même fonction en utilisant l'opérateur `*.`, on aurait eu une autre signature : `float -> float -> float`, parce que `*.` est défini pour les nombres décimaux.
