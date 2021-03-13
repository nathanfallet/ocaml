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
import UIKit
import Sourceful

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
    func height() -> CGFloat
    
}

protocol LearnChapterCell {
    
    static var identifier: String { get }
    func with(element: LearnChapterElement, in tableView: UITableView) -> UITableViewCell
    
}

struct LearnTitle: LearnChapterElement {
    
    var cell: LearnChapterCell.Type { return LearnChapterTitleTableViewCell.self }
    var content: String
    func height() -> CGFloat { return UITableView.automaticDimension }
    
}

struct LearnParagraph: LearnChapterElement {
    
    var cell: LearnChapterCell.Type { return LearnChapterParagraphTableViewCell.self }
    var content: String
    func height() -> CGFloat { return UITableView.automaticDimension }
    
}

struct LearnCode: LearnChapterElement {
    
    var cell: LearnChapterCell.Type { return LearnChapterCodeTableViewCell.self }
    var content: String
    
    func height() -> CGFloat {
        let theme = CustomTheme.shared
        let size = (content as NSString).size(withAttributes: theme.globalAttributes())
        return size.height + 54
    }
    
}
