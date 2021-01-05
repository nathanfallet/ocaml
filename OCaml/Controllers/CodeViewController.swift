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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play"), style: .plain, target: self, action: #selector(execute(_:)))
        
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
    
}
