---
layout: page
lang: fr
ref: learn_collections_lists
---

# Listes

## Créer une liste

Une liste est un ensemble d'éléments. Elle est représentée par une tête, le premier élément de la liste, et une queue, une autre liste qui contient les autres éléments. Une liste peut être déclarée comme un tableau, avec des `[` et `]`, ou en joignant une tête et une queue avec l'opérateur `::`.

```ocaml
let list1 = [1; 2; 3; 4];;
let list2 = 1 :: 2 :: 3 :: 4 :: [];;
let list3 = 0 :: list1;; (* [0; 1; 2; 3; 4] *)
```

## Taille d'une liste

Vous pouvez récupérer la taille d'une liste en utilisant la méthode `List.length` :

```ocaml
let list1 = [1; 2; 3; 4];;
let len = List.length list1;; (* len = 4 *)
```

## Récupérer un élément d'une liste

Comme une liste est représentée par une tête et une queue, vous pouvez seulement obtenir la tête et la queue d'une liste.

```ocaml
let list1 = [1; 2; 3; 4];;
let head = List.hd list1;; (* head = 1 *)
let tail = List.tl list1;; (* tail = [2; 3; 4] *)
```

Une meilleur manière de récupérer la tête et la queue d'une liste en utilisant un filtrage dans une fonction récursive :

```ocaml
let rec iterate list =
    match list with
    | [] -> print_newline()
    | head :: tail ->
        print_int head;
        print_string " ";
        iterate tail;;

iterate [1; 2; 3; 4];;
```

Dans cette fonction d'exemple, on affiche la tête, et on appel encore la fonction pour la queue. Et quand la queue est vide, on affiche une nouvelle ligne et la fonction s'arrête.
