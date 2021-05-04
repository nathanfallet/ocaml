---
layout: page
lang: fr
ref: learn_basics_variables
---

# Variables

## Définition de variables locales et globales

Une variable est un endroit en mémoire dans lequel on enregistre une valeur. On déclare une variable en OCaml de cette façon :

```ocaml
let x = 3;;
```

Le mot clé `let` indique que l'on défini une variable. Ensuite vient le nom de la variable, `x`, qui est définie à une valeur, `3`. La variable est définie globalement (elle est accessible de partout) et est immuable (sa valeur ne peut pas être changée)

Une variable peut aussi être définie localement :

```ocaml
(* On défini une variable locale x *)
let x = 3 in
x + 4;;

(* Ici on a une erreur *)
x + 4;;
```

Dans la première expression, on défini une variable, x, disponible dans tout ce qui suit le mot clé `in`, jusqu'à ce qu'on atteigne des `;;`. Dont `x + 4` est évalué à `7`. Cependant, dans la seconde expression, x n'est pas défini, par il a été déclaré localement dans l'autre expression. Donc on aura une erreur.

## Types de variable

Il y a différents types de variables en OCaml. Dans l'exemple précédent, x était un entier, connu comme le type `int`. Voici les types de variables disponibles en OCaml :

```ocaml
let x = 3;; (* int *)
let y = 3.0;; (* float *)
let test = true;; (* bool *)
let txt = "Hello";; (* string *)
let a = 'a';; (* char *)
let empty = ();; (* unit *)
```

`int` et `float` représentent des entiers et des décimaux.

`bool` représente les booléens, vrai ou faux (true/false).

`string` représente les chaines de caractères.

`char` représente un caractère seul.

Notez qu'un caractère est défini avec des guillemets simples, alors qu'une chaine de caractères est définie avec des guillemets doubles.

Enfin, `unit` est le type qui ne représente rien.

## Déclarer des références (variables mutables)

On peut déclarer des variables mutables, appelées références :

```ocaml
let x = ref 3;;
```

Ici, x ne contient pas la valeur 3, mais une référence à la valeur 3. De cette manière, on peut changer la valeur vers laquelle x pointe, ce qui n'est pas possible avec une variable classique. Les références peuvent s'avérer utiles pour des boucles dans lesquelles on doit incrémenter une valeur à chaque tour, par exemple.

```ocaml
let x = ref 3;;
x := 4;; (* 1 *)
x;; (* 2 *)
!x;; (* 3 *)
```

L'instruction 1 définie la valeur de la référence à 4. Notez l'usage du `:=` au lieu de `=` pour définir la valeur de la référence au lieu de la valeur de la variable (qui ne fonctionnerait pas). L'instruction 2 retourne la référence (de type `int ref`), alors que l'instruction 3 retourne la valeur de la référence (ici `4`, de type `int`).
