---
layout: page
lang: fr
ref: learn_collections_strings
---

# Chaines de caractères

## Caractères

```ocaml
let c = 'A';;
```

## Chaines de caractères

Les chaines de caractères agissent comme un tableau de caractères :

```ocaml
let str1 = "Hello world";;
let str2 = String.make 5 'A';;
```

De la même manière que vous pouvez obtenir la taille d'un tableau, vous pouvez obtenir la taille d'un chaine de caractères :

```ocaml
let str1 = "Hello world";;
let len = String.length str1;; (* len = 11 *)
```

## Récupérer un caractère d'une chaine

Ça fonctionne comme pour les tableaux, mais en utilisant `[]` au lieu de `()` :

```ocaml
let str1 = "Hello world!";;
let c = str1.[3];; (* c = 'o' *)
```

## Concaténation de chaines

Vous pouvez concaténer des chaines de caractères en utilisant l'opérateur `^` :

```ocaml
let name = "Nathan" in
let hello = "Hello " ^ name in
print_endline hello;;
```
