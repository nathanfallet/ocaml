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
import Sourceful
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

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
    
    var id: String { get }
    
}

struct LearnTitle: LearnChapterElement {
    
    var id: String { content }
    var content: String
    
}

struct LearnParagraph: LearnChapterElement {
    
    var id: String { content }
    var content: String
    
}

struct LearnCode: LearnChapterElement {
    
    var id: String { content }
    var content: String
    
    func height() -> CGFloat {
        let size = (content as NSString).size(withAttributes: [
            NSAttributedString.Key.font: Sourceful.Font.monospacedSystemFont(ofSize: 14, weight: .regular)
        ])
        return size.height + 16
    }
    
}
