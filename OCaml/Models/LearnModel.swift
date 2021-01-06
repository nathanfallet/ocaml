//
//  LearnModel.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import Foundation
import UIKit

/*
 Sequence
 */

struct LearnSequence {
    
    var title: String
    var elements: [LearnSequenceElement]
    
}

/*
 Sequence elements
 */

protocol LearnSequenceElement {
    
    var title: String { get }
    var type: String { get }
    
}

extension LearnSequenceElement {
    
    var isCompleted: Bool {
        get {
            UserDefaults.standard.bool(forKey: "\(title)_completed")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "\(title)_completed")
            UserDefaults.standard.synchronize()
        }
    }
    
}

struct LearnChapter: LearnSequenceElement {
    
    var title: String
    var type: String { return "chapter" }
    var elements: [LearnChapterElement]
    
}

struct LearnQuiz: LearnSequenceElement {
    
    var title: String
    var type: String { return "quiz" }
    
}

/*
 Chapter elements
 */

protocol LearnChapterElement {
    
    var cell: LearnChapterCell.Type { get }
    
}

protocol LearnChapterCell {
    
    static var identifier: String { get }
    func with(element: LearnChapterElement, in tableView: UITableView) -> UITableViewCell
    
}

struct LearnTitle: LearnChapterElement {
    
    var cell: LearnChapterCell.Type { return LearnChapterTitleTableViewCell.self }
    var content: String
    
}

struct LearnParagraph: LearnChapterElement {
    
    var cell: LearnChapterCell.Type { return LearnChapterParagraphTableViewCell.self }
    var content: String
    
}

struct LearnCode: LearnChapterElement {
    
    var cell: LearnChapterCell.Type { return LearnChapterCodeTableViewCell.self }
    var content: String
    
}
