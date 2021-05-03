---
layout: page
lang: en
ref: learn_collections_arrays
---

# Arrays

## Create an array

An array is a fixed length set of elements. There are two ways to create an array: either by specifing each element, semicolon separated, between `[|` and `|]`, or by repeting an element a fixed number of times.

```ocaml
let array1 = [|1; 2; 3; 4|];;
let array2 = Array.make 3 0;; (* [|0; 0; 0|] *)
```

## Array length

You can get the length of an array using the `Array.length` method:

```ocaml
let array1 = [|1; 2; 3; 4|];;
let len = Array.length array1;; (* len = 4 *)
```

## Get an element from an array

You can get elements from an array using its index. The first element's index is `0`, and the last one's index is `n-1`, for an array of length `n`.

```ocaml
let array1 = [|1; 2; 3; 4|] in
print_int array1.(2);; (* 3 *)
```

Using a for loop, you can iterate elements of an array like in this example:

```ocaml
let array1 = [|1; 2; 3; 4|] in
let len = Array.length array1 in
for k = 0 to len-1 do
    print_int array1.(k)
done;;
```

In this example, `k` will be incremented from `0` to `3` (`len` is `4` so `len-1` is `3`), and for each value of `k`, the element with the index `k` will be printed. That way, we can print all elements of an array.

## Set an element in an array

You can also set an element to a new value with its index using an arrow:

```ocaml
let array1 = [|1; 2; 3; 4|] in
let len = Array.length array1 in
for k = 0 to len-1 do
    array1.(k) <- 2 * array1.(k)
done;;
(* array1 = [|2; 4; 6; 8|] *)
```

In this example, each value of the array is replaced by 2 times the original value.
