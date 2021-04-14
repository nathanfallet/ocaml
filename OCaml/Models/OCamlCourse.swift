/*
*  Copyright (C) 2021 Groupe MINASTE
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*/

import Foundation

class OCamlCourse {
    
    // Course content
    static let content = [
        // Basics
        LearnSequence(title: "sequence_basics", elements: [
            // Discover
            LearnChapter(title: "chapter_discover_title", elements: [
                LearnTitle(content: "chapter_discover_title"),
                LearnParagraph(content: "chapter_discover_welcome"),
                LearnCode(content: """
                    (* \("chapter_discover_comment".localized()) *)
                    print_endline "Hello, world!";;
                    """),
                LearnParagraph(content: "chapter_discover_first"),
                LearnParagraph(content: "chapter_discover_second"),
            ]),
            
            // Variables
            LearnChapter(title: "chapter_variables_title", elements: [
                LearnTitle(content: "chapter_variables_def"),
                LearnParagraph(content: "chapter_variables_intro"),
                LearnCode(content: """
                    let x = 3;;
                    """),
                LearnParagraph(content: "chapter_variables_def_global"),
                LearnParagraph(content: "chapter_variables_def_local"),
                LearnCode(content: """
                    (* \("chapter_variables_def_local_comment1".localized()) *)
                    let x = 3 in
                    x + 4;;

                    (* \("chapter_variables_def_local_comment2".localized()) *)
                    x + 4;;
                    """),
                LearnParagraph(content: "chapter_variables_def_local2"),
                LearnTitle(content: "chapter_variables_types"),
                LearnParagraph(content: "chapter_variables_types_intro"),
                LearnCode(content: """
                    let x = 3;; (* int *)
                    let y = 3.0;; (* float *)
                    let test = true;; (* bool *)
                    let txt = "Hello";; (* string *)
                    let a = 'a';; (* char *)
                    let empty = ();; (* unit *)
                    """),
                LearnParagraph(content: "chapter_variables_types_description"),
                LearnTitle(content: "chapter_variables_references"),
                LearnParagraph(content: "chapter_variables_references_intro"),
                LearnCode(content: """
                    let x = ref 3;;
                    """),
                LearnParagraph(content: "chapter_variables_references_def"),
                LearnCode(content: """
                    let x = ref 3;;
                    
                    x := 4;; (* 1 *)
                    
                    x;; (* 2 *)
                    
                    !x;; (* 3 *)
                    """),
                LearnParagraph(content: "chapter_variables_references_details"),
            ]),
            
            // Operations on numbers
            LearnChapter(title: "chapter_operations_title", elements: [
                LearnTitle(content: "chapter_operations_integers"),
                LearnParagraph(content: "chapter_operations_integers_intro"),
                LearnCode(content: """
                    let a = 2 + 3 - 1;; (* a = 4 *)
                    let b = 7 * 4;; (* b = 28 *)
                    let c = 7 / 4;; (* c = 1 *)
                    let d = 7 mod 4;; (* d = 3 *)
                    """),
                LearnTitle(content: "chapter_operations_floats"),
                LearnParagraph(content: "chapter_operations_floats_intro"),
                LearnCode(content: """
                    let a = 2.7 +. 3.2 -. 0.5;; (* a = 5.4 *)
                    let b = 1.7 *. 0.2 /. 0.1;; (* b = 3.4 *)
                    let c = 9.0 **. 0.5;; (* c = 3.0 *)
                    """),
                LearnTitle(content: "chapter_operations_funcs"),
                LearnParagraph(content: "chapter_operations_funcs_intro"),
                LearnCode(content: """
                    let a = cos 0.0 +. sin 1.0 -. tan 3.14;; (* a = 1.84... *)
                    let b = asin 1.0 *. acos 1.0 /. atan 1.0;; (* b = 0.0 *)
                    let c = sinh 2.4;; (* c = 5.46... *)
                    let d = exp 1.0;; (* d = 2.71... *)
                    let e = log 2.0;; (* e = 0.69... *)
                    let f = log10 2.0;; (* f = 0.30... *)
                    """),
                LearnTitle(content: "chapter_operations_print"),
                LearnParagraph(content: "chapter_operations_print_intro"),
                LearnCode(content: """
                    let a = 2 + 3 - 1 in
                    print_int a;;
                    let b = 2.7 +. 3.2 -. 0.5 in
                    print_float b;;
                    """),
            ]),
            
            // Conditions
            LearnChapter(title: "chapter_conditions_title", elements: [
                LearnTitle(content: "chapter_conditions_inline"),
                LearnParagraph(content: "chapter_conditions_inline_intro"),
                LearnCode(content: """
                    let a = 7 in
                    let b = if a > 5 then "++" else "--" in
                    print_endline b;; (* ++ *)
                    """),
                LearnTitle(content: "chapter_conditions_multiline"),
                LearnParagraph(content: "chapter_conditions_multiline_intro"),
                LearnCode(content: """
                    let a = 7 in
                    if a > 5 then begin
                        let b = "++" in
                        print_endline b
                    end else begin
                        let b = "--" in
                        print_endline b
                    end;;
                    """),
                LearnTitle(content: "chapter_conditions_operators"),
                LearnParagraph(content: "chapter_conditions_operators_intro"),
                LearnParagraph(content: "chapter_conditions_operators_logical"),
                LearnCode(content: """
                    let a = 7 in
                    let b = 5 in
                    let t = if a > b && a - b <> 1 then "ok" else "not ok" in
                    print_endline t;; (* ok *)
                    """),
            ]),
            
            // Loops
            LearnChapter(title: "chapter_loops_title", elements: [
                LearnTitle(content: "chapter_loops_conditional"),
                LearnParagraph(content: "chapter_loops_conditional_intro"),
                LearnCode(content: """
                    let i = ref 10 in
                    while !i > 0 do
                        print_endline "Hello world";
                        i := !i - 1
                    done;;
                    """),
                LearnTitle(content: "chapter_loops_unconditional"),
                LearnParagraph(content: "chapter_loops_unconditional_intro"),
                LearnCode(content: """
                    for k = 1 to 10 do
                        print_endline ("Hello world " ^ (string_of_int k));
                    done;;
                    """),
            ]),
            
            // Match
            LearnChapter(title: "chapter_match_title", elements: [
                LearnTitle(content: "chapter_match_title"),
                LearnParagraph(content: "chapter_match_intro"),
                LearnCode(content: """
                    let i = 10 in
                    let name = match i with
                    | 1 -> "1st"
                    | 2 -> "2nd"
                    | 3 -> "3rd"
                    | _ -> (string_of_int i) ^ "th"
                    in print_string name;;
                    """),
                LearnParagraph(content: "chapter_match_intro_details"),
                LearnTitle(content: "chapter_match_when_title"),
                LearnParagraph(content: "chapter_match_when_intro"),
                LearnCode(content: """
                    let i = 10 in
                    let p = match i with
                    | n when n mod 2 = 0 -> "Even"
                    | _ -> "Odd"
                    in print_string p;;
                    """),
            ]),
        ]),
        
        // Functions
        LearnSequence(title: "sequence_functions", elements: [
            // Declare a function
            LearnChapter(title: "chapter_functions_declaration_title", elements: [
                LearnTitle(content: "chapter_functions_declaration_title"),
                LearnParagraph(content: "chapter_functions_declaration_intro"),
                LearnCode(content: """
                    let multiply a b =
                        a * b;;

                    let n = multiply 3 4;; (* n = 12 *)
                    """),
                LearnParagraph(content: "chapter_functions_declaration_details"),
                LearnParagraph(content: "chapter_functions_declaration_returns"),
                LearnParagraph(content: "chapter_functions_declaration_calls"),
            ]),
            
            // Function signatures
            LearnChapter(title: "chapter_function_signature_title", elements: [
                LearnTitle(content: "chapter_function_signature_title"),
                LearnParagraph(content: "chapter_function_signature_intro"),
                LearnCode(content: """
                    let multiply a b =
                        a * b;;
                    """),
                LearnParagraph(content: "chapter_function_signature_details"),
                LearnParagraph(content: "chapter_function_signature_auto"),
            ]),
            
            // Recursive functions
            LearnChapter(title: "chapter_function_recursive_title", elements: [
                LearnTitle(content: "chapter_function_recursive_title"),
                LearnParagraph(content: "chapter_function_recursive_intro"),
                LearnCode(content: """
                    let rec factorial n =
                        if n = 0 then 1 else n * (factorial (n-1));;
                    """),
                LearnParagraph(content: "chapter_function_recursive_example"),
            ]),
        ]),
        
        // Collections
        LearnSequence(title: "sequence_collections", elements: [
            // Arrays
            LearnChapter(title: "chapter_arrays_title", elements: [
                LearnTitle(content: "chapter_arrays_create"),
                LearnParagraph(content: "chapter_arrays_create_intro"),
                LearnCode(content: """
                    let array1 = [|1; 2; 3; 4|];;
                    let array2 = Array.make 3 0;; (* [|0; 0; 0|] *)
                    """),
                LearnTitle(content: "chapter_arrays_length"),
                LearnParagraph(content: "chapter_arrays_length_intro"),
                LearnCode(content: """
                    let array1 = [|1; 2; 3; 4|];;
                    let len = Array.length array1;; (* len = 4 *)
                    """),
                LearnTitle(content: "chapter_arrays_get"),
                LearnParagraph(content: "chapter_arrays_get_intro"),
                LearnCode(content: """
                    let array1 = [|1; 2; 3; 4|] in
                    print_int array1.(2);; (* 3 *)
                    """),
                LearnParagraph(content: "chapter_arrays_interate"),
                LearnCode(content: """
                    let array1 = [|1; 2; 3; 4|] in
                    let len = Array.length array1 in
                    for k = 0 to len-1 do
                        print_int array1.(k)
                    done;;
                    """),
                LearnParagraph(content: "chapter_arrays_interate_details"),
                LearnTitle(content: "chapter_arrays_set"),
                LearnParagraph(content: "chapter_arrays_set_intro"),
                LearnCode(content: """
                    let array1 = [|1; 2; 3; 4|] in
                    let len = Array.length array1 in
                    for k = 0 to len-1 do
                        array1.(k) <- 2 * array1.(k)
                    done;;
                    (* array1 = [|2; 4; 6; 8|] *)
                    """),
                LearnParagraph(content: "chapter_arrays_set_details"),
            ]),
            
            // Lists
            LearnChapter(title: "chapter_lists_title", elements: [
                LearnTitle(content: "chapter_lists_create"),
                LearnParagraph(content: "chapter_lists_create_intro"),
                LearnCode(content: """
                    let list1 = [1; 2; 3; 4];;
                    let list2 = 1 :: 2 :: 3 :: 4 :: [];;
                    let list3 = 0 :: list1;; (* [0; 1; 2; 3; 4] *)
                    """),
                LearnTitle(content: "chapter_lists_length"),
                LearnParagraph(content: "chapter_lists_length_intro"),
                LearnCode(content: """
                    let list1 = [1; 2; 3; 4];;
                    let len = List.length list1;; (* len = 4 *)
                    """),
                LearnTitle(content: "chapter_lists_get"),
                LearnParagraph(content: "chapter_lists_get_intro"),
                LearnCode(content: """
                    let list1 = [1; 2; 3; 4];;
                    let head = List.hd list1;; (* head = 1 *)
                    let tail = List.tl list1;; (* tail = [2; 3; 4] *)
                    """),
                LearnParagraph(content: "chapter_lists_match"),
                LearnCode(content: """
                    let rec iterate list =
                        match list with
                        | [] -> print_newline()
                        | head :: tail ->
                            print_int head;
                            print_string " ";
                            iterate tail;;
                    
                    iterate [1; 2; 3; 4];;
                    """),
                LearnParagraph(content: "chapter_lists_interate_details"),
            ]),
            
            // Strings
            LearnChapter(title: "chapter_strings_title", elements: [
                LearnTitle(content: "chapter_strings_character"),
                LearnCode(content: """
                    let c = 'A';;
                    """),
                LearnTitle(content: "chapter_strings_title"),
                LearnParagraph(content: "chapter_strings_intro"),
                LearnCode(content: """
                    let str1 = "Hello world";;
                    let str2 = String.make 5 'A';;
                    """),
                LearnParagraph(content: "chapter_strings_length"),
                LearnCode(content: """
                    let str1 = "Hello world";;
                    let len = String.length str1;; (* len = 11 *)
                    """),
                LearnTitle(content: "chapter_strings_get"),
                LearnParagraph(content: "chapter_strings_get_intro"),
                LearnCode(content: """
                    let str1 = "Hello world!";;
                    let c = str1.[3];; (* c = 'o' *)
                    """),
                LearnTitle(content: "chapter_strings_concatenation"),
                LearnParagraph(content: "chapter_strings_concatenation_intro"),
                LearnCode(content: """
                    let name = "Nathan" in
                    let hello = "Hello " ^ name in
                    print_endline hello;;
                    """),
            ]),
        ]),
        
        // Exercices
        LearnSequence(title: "sequence_exercices", elements: [
            // Basics
            LearnChapter(title: "chapter_exercices_basics", elements: [
                LearnTitle(content: "chapter_exercices_basics"),
                LearnParagraph(content: "chapter_exercices_basics_function1"),
                LearnParagraph(content: "chapter_exercices_basics_function2"),
                LearnTitle(content: "chapter_exercices_arrays"),
                LearnParagraph(content: "chapter_exercices_arrays_print"),
                LearnParagraph(content: "chapter_exercices_arrays_sum"),
            ]),
        ]),
    ]
    
}
