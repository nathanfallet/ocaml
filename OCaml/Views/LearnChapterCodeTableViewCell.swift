//
//  LearnChapterCodeTableViewCell.swift
//  OCaml
//
//  Created by Nathan FALLET on 06/01/2021.
//

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
