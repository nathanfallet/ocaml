//
//  CodeViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit
import Sourceful

class CodeViewController: UIViewController, SyntaxTextViewDelegate {
    
    let editor = CustomSyntaxTextView()
    let executor = OCamlExecutor()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "code".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play"), style: .plain, target: nil, action: nil)
        
        // Setup view
        view.addSubview(editor)
        editor.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        editor.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        editor.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        editor.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        editor.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure it
        editor.delegate = self
        editor.theme = CustomTheme()
    }
    
    // Give the OCaml lexer
    func lexerForSource(_ source: String) -> Lexer {
        return OCamlLexer()
    }
    
}
