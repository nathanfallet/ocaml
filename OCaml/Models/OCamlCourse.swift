//
//  OCamlCourse.swift
//  OCaml
//
//  Created by Nathan FALLET on 06/01/2021.
//

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
                LearnParagraph(content: "chapter_discover_second")
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
            ])
        ])
    ]
    
}
