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
                    (* This is OCaml code *)
                    print_endline "Hello, world!";;
                    """)
            ]),
            
            // Variables
            LearnChapter(title: "chapter_variables_title", elements: [
                
            ])
        ])
    ]
    
}
