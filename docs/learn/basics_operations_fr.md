---
layout: page
lang: fr
ref: learn_basics_operations
---

# Opérations sur les nombres

## Opérations sur les entiers

En OCaml, comme dans tous les langages, on peut ajouter, soustraire, multiplier et diviser des nombres. `+` est l'addition, `-` la différence, `*` le produit, `/` le quotient, et `mod` le reste.

```ocaml
let a = 2 + 3 - 1;; (* a = 4 *)
let b = 7 * 4;; (* b = 28 *)
let c = 7 / 4;; (* c = 1 *)
let d = 7 mod 4;; (* d = 3 *)
```

## Opérations sur les nombres décimaux

Le même genre d'opération peut être appliqué sur les nombres décimaux, mais les opérateurs ne sont pas les mêmes et contiennent un `.` pour indiquer qu'ils s'appliquent sur les décimaux et non les entiers.

```ocaml
let a = 2.7 +. 3.2 -. 0.5;; (* a = 5.4 *)
let b = 1.7 *. 0.2 /. 0.1;; (* b = 3.4 *)
let c = 9.0 **. 0.5;; (* c = 3.0 *)
```

## Fonctions usuelles

Les fonctions usuelles comme `sin` sont aussi disponibles en OCaml :

```ocaml
let a = cos 0.0 +. sin 1.0 -. tan 3.14;; (* a = 1.84... *)
let b = asin 1.0 *. acos 1.0 /. atan 1.0;; (* b = 0.0 *)
let c = sinh 2.4;; (* c = 5.46... *)
let d = exp 1.0;; (* d = 2.71... *)
let e = log 2.0;; (* e = 0.69... *)
let f = log10 2.0;; (* f = 0.30... *)
```

## Afficher des nombres dans la console

Vous pouvez afficher des nombres dans la console en utilisant `print_int` et `print_float` :

```ocaml
let a = 2 + 3 - 1 in
print_int a;;
let b = 2.7 +. 3.2 -. 0.5 in
print_float b;;
```
