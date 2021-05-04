---
layout: page
lang: fr
ref: learn_basics_conditions
---

# Conditions

## Conditions en ligne

Vous pouvez utiliser des conditions en ligne dans n'importe quelle expression avec une instruction `if … then … else …` comme le fait cet exemple :

```ocaml
let a = 7 in
let b = if a > 5 then "++" else "--" in
print_endline b;; (* ++ *)
```

## Conditions sur plusieurs lignes

Dans le cas où vous avez besoin d'exécuter plusieurs instructions, vous pouvez créer des conditions sur plusieurs lignes en ajoutant les mots clés `begin` et `end`.

```ocaml
let a = 7 in
if a > 5 then begin
    let b = "++" in
    print_endline b
end else begin
    let b = "--" in
    print_endline b
end;;
```

## Opérateurs conditionnels

Les opérateurs de comparaison classiques `<`, `>`, `<=`, `>=` sont les mêmes que d'habitude. Pour les opérateurs d'égalité, `=` est utilisé pour les comparaisons par valeur, alors que `==` est utilisé pour les comparaisons par adresse mémoire. De la même manière, `<>` est l'inégalité par valeur et `!=` l'inégalité par adresse mémoire.

Vous pouvez combiner les conditions en utilisant des opérateurs logiques : `&&` pour et, `||` pour ou, et `not` pour non.

```ocaml
let a = 7 in
let b = 5 in
let t = if a > b && a - b <> 1 then "ok" else "not ok" in
print_endline t;; (* ok *)
```
