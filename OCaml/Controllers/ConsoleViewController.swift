//
//  ConsoleViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit

class ConsoleViewController: UIViewController {
    
    let output = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "console".localized()
        
        // Setup view
        view.addSubview(output)
        output.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        output.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        output.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        output.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        output.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure it
        output.isEditable = false
        output.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        output.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        output.textContainerInset = .zero
    }

}
