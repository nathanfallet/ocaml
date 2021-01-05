//
//  LearnModel.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import Foundation

struct LearnSequence {
    
    var title: String
    var elements: [LearnSequenceElement]
    
}

protocol LearnSequenceElement {
    
    var title: String { get }
    var type: String { get }
    
}

struct LearnChapter: LearnSequenceElement {
    
    var title: String
    var type: String { return "chapter" }
    
}
