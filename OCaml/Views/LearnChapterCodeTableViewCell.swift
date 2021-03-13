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

import UIKit
import Sourceful

class LearnChapterCodeTableViewCell: UITableViewCell, LearnChapterCell {

    static var identifier: String { return "codeCell" }

    var box = CustomSyntaxTextView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(box)
        
        box.setup()
        box.translatesAutoresizingMaskIntoConstraints = false
        box.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        box.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        box.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true
        box.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        box.contentTextView.isEditable = false
        box.contentTextView.isScrollEnabled = true
        box.clipsToBounds = true
        box.layer.cornerRadius = 8
        box.shouldAddMargin = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func with(element: LearnChapterElement, in tableView: UITableView) -> UITableViewCell {
        if let code = element as? LearnCode {
            box.text = code.content
        }
        
        return self
    }

}
