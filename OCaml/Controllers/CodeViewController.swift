//
//  CodeViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit
import Sourceful

class CodeViewController: UIViewController, SyntaxTextViewDelegate {
    
    // Views
    let editor = CustomSyntaxTextView()
    let executor = OCamlExecutor()
    
    // Buttons
    let play = UIBarButtonItem(image: UIImage(systemName: "play.fill"), style: .plain, target: self, action: #selector(execute(_:)))
    let open = UIBarButtonItem(image: UIImage(systemName: "doc.fill"), style: .plain, target: self, action: #selector(close(_:)))
    let save = UIBarButtonItem(image: UIImage(systemName: "arrow.down.doc.fill"), style: .plain, target: self, action: #selector(close(_:)))
    let close = UIBarButtonItem(image: UIImage(systemName: "clear.fill"), style: .plain, target: self, action: #selector(close(_:)))

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "code".localized()
        navigationItem.leftBarButtonItems = [open, save, close]
        navigationItem.rightBarButtonItem = play
        
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
        
        // Add toolbar to editor
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: editor.contentTextView, action: #selector(UIResponder.resignFirstResponder))
        ]
        toolbar.sizeToFit()
        editor.contentTextView.inputAccessoryView = toolbar
    }
    
    // Give the OCaml lexer
    func lexerForSource(_ source: String) -> Lexer {
        return OCamlLexer()
    }
    
    // Execute content (play button)
    @objc func execute(_ sender: UIBarButtonItem) {
        // Get source code
        let source = self.editor.text
        
        // Compile it
        self.executor.compile(source: source) { javascript, error in
            // Check if it was compiled
            if let javascript = javascript {
                // Execute it
                self.executor.run(javascript: javascript) { entries in
                    // Process entries
                    let output = entries.map{ $0.description }.joined(separator: "\n")
                    
                    // Present output in a console view controller
                    let controller = ConsoleViewController()
                    controller.output.text = output
                    self.navigationController?.pushViewController(controller, animated: true)
                }
            } else {
                // Handler errors
                if let error = error {
                    print("Error: \(error)")
                } else {
                    print("Unknown error")
                }
            }
        }
    }
    
    // Close file
    @objc func close(_ sender: UIBarButtonItem) {
        // Clear source code
        self.editor.text = ""
    }
    
}
