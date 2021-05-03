---
layout: page
lang: en
ref: learn_collections_lists
---

# Lists

## Create a list

A list is a set of elements. It is represented with a head, the first element of the list, and a tail, another list containing other elements. A list can be declared with an array-like way, using `[` and `]`, or by joining a head with a tail using the `::` operator.

```ocaml
let list1 = [1; 2; 3; 4];;
let list2 = 1 :: 2 :: 3 :: 4 :: [];;
let list3 = 0 :: list1;; (* [0; 1; 2; 3; 4] *)
```

## List length

You can get the length of a list using the `List.length` method:

```ocaml
let list1 = [1; 2; 3; 4];;
let len = List.length list1;; (* len = 4 *)
```

## Get an element from a list

As a list is represented by a head and a tail, you can only get the head and the tail of a list.

```ocaml
let list1 = [1; 2; 3; 4];;
let head = List.hd list1;; (* head = 1 *)
let tail = List.tl list1;; (* tail = [2; 3; 4] *)
```

A better way to get the head and the tail of a list is using the pattern matching in a recursive function:

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

In this example function, we print the head, and call the function again for the tail. And when the tail is empty, we print a new line and the function stops.
