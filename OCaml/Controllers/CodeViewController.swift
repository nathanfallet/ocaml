//
//  CodeViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit
import Sourceful

class CodeViewController: UIViewController, SyntaxTextViewDelegate, UIDocumentPickerDelegate {
    
    // Views
    let editor = CustomSyntaxTextView()
    let executor = OCamlExecutor()
    
    // Buttons
    let play = UIBarButtonItem(image: UIImage(systemName: "play.fill"), style: .plain, target: self, action: #selector(execute(_:)))
    let open = UIBarButtonItem(image: UIImage(systemName: "doc.fill"), style: .plain, target: self, action: #selector(open(_:)))
    let save = UIBarButtonItem(image: UIImage(systemName: "arrow.down.doc.fill"), style: .plain, target: self, action: #selector(save(_:)))
    let close = UIBarButtonItem(image: UIImage(systemName: "clear.fill"), style: .plain, target: self, action: #selector(close(_:)))
    
    // File properties
    var currentFile: URL?

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
                let alert = UIAlertController(title: "error".localized(), message: nil, preferredStyle: .alert)
                switch error {
                    case .commentsNotSupported:
                        alert.message = "error_commentsNotSupported".localized()
                    case .fromJS(let jsError):
                        alert.message = "error_fromJS".localized().format(jsError)
                    default:
                        alert.message = "error_unknown".localized()
                }
                alert.addAction(UIAlertAction(title: "button_ok".localized(), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Open file
    @objc func open(_ sender: UIBarButtonItem) {
        // Create a document picker
        let picker = UIDocumentPickerViewController(documentTypes: ["ml"], in: .open)
        
        // Handle selected file
        picker.delegate = self
        
        // Show picker
        self.present(picker, animated: true, completion: nil)
    }
    
    // Save file
    @objc func save(_ sender: UIBarButtonItem) {
        // Check if a file is opened
        if let currentFile = currentFile {
            // Save file content
            try? editor.text.write(to: currentFile, atomically: true, encoding: .utf8)
        } else {
            // Create a document picker
            // TODO
        }
    }
    
    // Close file
    @objc func close(_ sender: UIBarButtonItem) {
        // Clear source code
        self.editor.text = ""
        
        // Close current file
        self.currentFile = nil
    }
    
    // Handle selected file
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Check mode
        if controller.documentPickerMode == .open, let url = urls.first {
            // Get URL
            self.currentFile = url
            
            // Open file in editor
            self.editor.text = (try? String(contentsOf: url)) ?? ""
        }
    }
    
}
