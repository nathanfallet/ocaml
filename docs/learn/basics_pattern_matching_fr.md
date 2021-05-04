---
layout: page
lang: fr
ref: learn_basics_pattern_matching
---

# Filtrage

## Filtrage

Le filtrage permet de reconnaitre quelque chose avec différents cas :

```ocaml
let i = 10 in
let name = match i with
| 1 -> "1st"
| 2 -> "2nd"
| 3 -> "3rd"
| _ -> (string_of_int i) ^ "th"
in print_string name;;
```

Dans cet exemple, on filtre la valeur de i avec différents cas : si i correspond à 1, on retourne 1st, … et le dernier cas, représenté par un `_` correspond à tout le reste (c'est un cas par défaut). Notez que toutes les valeurs possibles doivent être associées avec un cas du filtrage : il doit être exhaustif.

## Filtrage en utilisant 'when'

Le mot clé `when` permet d'ajouter une condition à un cas :

```ocaml
let i = 10 in
let p = match i with
| n when n mod 2 = 0 -> "Pair"
| _ -> "Impair"
in print_string p;;
```
