---
layout: page
lang: fr
ref: learn_collections_arrays
---

# Tableaux

## Créer un tableau

Un tableau est un ensemble d'éléments de taille fixé. Il y a deux manières de créer un tableau : soit en spécifiant chaque élément, séparés par des point-virgules, entre `[|` et `|]`, soit en répétant un élément un nombre fixé de fois.

```ocaml
let array1 = [|1; 2; 3; 4|];;
let array2 = Array.make 3 0;; (* [|0; 0; 0|] *)
```

## Taille d'un tableau

Vous pouvez récupérer la taille d'un tableau en utilisant la méthode `Array.length` :

```ocaml
let array1 = [|1; 2; 3; 4|];;
let len = Array.length array1;; (* len = 4 *)
```

## Récupérer un élément d'un tableau

Vous pouvez récupérer un élément d'un tableau en utilisant son indice. L'indice du premier élément est `0`, et celui du dernier est `n-1`, pour un tableau de taille `n`.

```ocaml
let array1 = [|1; 2; 3; 4|] in
print_int array1.(2);; (* 3 *)
```

En utilisant une boucle for, vous pouvez itérer les éléments d'un tableau comme dans cet exemple :

```ocaml
let array1 = [|1; 2; 3; 4|] in
let len = Array.length array1 in
for k = 0 to len-1 do
    print_int array1.(k)
done;;
```

Dans cet exemple, `k` va être incrémenté de `0` à `3` (`len` est `4` donc `len-1` est `3`), et pour chaque valeur de `k`, l'élément d'indice `k` va être affiché. De cette manière, on peut afficher tous les éléments d'un tableau.

## Définir un élément d'un tableau

Vous pouvez aussi remplacer un élément d'un tableau par une nouvelle valeur avec son indice en utilisant une flèche :

```ocaml
let array1 = [|1; 2; 3; 4|] in
let len = Array.length array1 in
for k = 0 to len-1 do
    array1.(k) <- 2 * array1.(k)
done;;
(* array1 = [|2; 4; 6; 8|] *)
```

Dans cet exemple, chaque valeur du tableau est remplacée par le double de la valeur d'origine.
