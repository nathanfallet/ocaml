//
//  AppTableViewCell.swift
//  OCaml
//
//  Created by Nathan FALLET on 01/03/2021.
//

import UIKit

class AppTableViewCell: UITableViewCell {

    let icon = UIImageView()
    let name = UILabel()
    let desc = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        selectionStyle = .none
            
        contentView.addSubview(icon)
        contentView.addSubview(name)
        contentView.addSubview(desc)
            
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        icon.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        icon.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 44).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 44).isActive = true
        icon.layer.masksToBounds = true
        icon.layer.cornerRadius = 8
            
        name.translatesAutoresizingMaskIntoConstraints = false
        name.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        name.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12).isActive = true
        name.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
            
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 4).isActive = true
        desc.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 12).isActive = true
        desc.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        desc.bottomAnchor.constraint(lessThanOrEqualTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        desc.font = .preferredFont(forTextStyle: .subheadline)
        desc.textColor = .secondaryLabel
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func with(name: String, desc: String, icon: UIImage?) -> AppTableViewCell {
        self.name.text = name
        self.desc.text = desc
        self.icon.image = icon
        
        return self
    }

}
