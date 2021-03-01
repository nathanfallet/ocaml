//
//  EditorColorTableViewCell.swift
//  OCaml
//
//  Created by Nathan FALLET on 01/03/2021.
//

import UIKit

class EditorColorTableViewCell: UITableViewCell {
    
    // Some states
    var currentEditingColor: (String, UIColor)?
    
    // UI elements
    let name = UILabel()
    let icon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(name)
        contentView.addSubview(icon)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        name.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.centerYAnchor.constraint(equalTo: name.centerYAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 12).isActive = true
        icon.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 17).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 17).isActive = true
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func with(id: String, current: UIColor) -> EditorColorTableViewCell {
        currentEditingColor = (id, current)
        
        self.name.text = id.localized()
        self.icon.backgroundColor = current
        
        return self
    }

}
