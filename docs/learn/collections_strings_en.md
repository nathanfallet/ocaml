---
layout: page
lang: en
ref: learn_collections_strings
---

# Strings

## Characters

```ocaml
let c = 'A';;
```

## Strings

Strings act like an array of characters:

```ocaml
let str1 = "Hello world";;
let str2 = String.make 5 'A';;
```

The same way you get an array length, you can get it for a string:

```ocaml
let str1 = "Hello world";;
let len = String.length str1;; (* len = 11 *)
```

## Get a character in a string

It works like arrays, but using `[]` instead of `()`:

```ocaml
let str1 = "Hello world!";;
let c = str1.[3];; (* c = 'o' *)
```

## String concatenation

You can concatenate strings using the `^` operator:

```ocaml
let name = "Nathan" in
let hello = "Hello " ^ name in
print_endline hello;;
```
