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
import StoreKit
import Sourceful
import UniformTypeIdentifiers

class CodeViewController: UIViewController, UIDocumentPickerDelegate, SyntaxTextViewDelegate {
    
    // Views
    let editor = CustomSyntaxTextView()
    
    // Opened files
    var files = [OCamlFile]()
    var currentIndex: Int? {
        didSet {
            currentIndexChanged()
        }
    }
    
    // Status management
    var opening = false
    var saving = false
    
    // Delegate
    weak var delegate: CodeExecutorDelegate?
    
    // Current file
    var currentFile: OCamlFile {
        // Check index
        if let index = currentIndex {
            // Return current file
            return files[index]
        } else {
            // Create a file if needed
            if files.isEmpty {
                files.append(OCamlFile())
            }
            
            // Set index to zero
            currentIndex = 0
            return files[0]
        }
    }

    // Load view
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "code".localized()
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "doc.badge.plus"), style: .plain, target: self, action: #selector(open(_:))),
            UIBarButtonItem(image: UIImage(systemName: "arrow.down.doc"), style: .plain, target: self, action: #selector(save(_:))),
            UIBarButtonItem(image: UIImage(systemName: "xmark.circle"), style: .plain, target: self, action: #selector(close(_:)))
        ]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "play"), style: .plain, target: self, action: #selector(execute(_:)))
        ]
        
        // Setup view
        view.addSubview(editor)
        editor.setup()
        editor.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        editor.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        editor.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        editor.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        editor.translatesAutoresizingMaskIntoConstraints = false
        editor.delegate = self
        
        // Add toolbar to editor
        let toolbar = UIToolbar()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: editor.contentTextView, action: #selector(UIResponder.resignFirstResponder))
        ]
        toolbar.sizeToFit()
        editor.contentTextView.inputAccessoryView = toolbar
        
        // Pre load console
        delegate?.execute("", show: false, completionHandler: {})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Reload content to be sure to have updated colors
        CustomTheme.shared.loadColors()
    }
    
    // Selected file changed
    func currentIndexChanged() {
        // First update the title
        updateTitle()
        
        // Then update editor content
        editor.text = currentFile.source
    }
    
    // Update title
    func updateTitle() {
        // Title from file
        navigationItem.title = (currentFile.name ?? "code".localized()) + (currentFile.edited ? " (*)" : "")
    }
    
    // Give the OCaml lexer
    func lexerForSource(_ source: String) -> Lexer {
        return OCamlLexer()
    }
    
    // Listen for content change
    func didChangeText(_ syntaxTextView: SyntaxTextView) {
        // Update file with source code
        currentFile.update(source: syntaxTextView.text)
        
        // Also update the title
        updateTitle()
    }
    
    // Execute content (play button)
    @objc func execute(_ sender: Any) {
        // Disable button while compiling
        //navigationItem.rightBarButtonItem?.isEnabled = false
        
        // Compile it
        delegate?.execute(currentFile.source, show: true) {
            // Enable back button
            //self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    // Open button
    @objc func open(_ sender: Any) {
        // Get identifier
        guard let identifier = UTType("public.ocaml") else { return }
        
        // Create a document picker
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [identifier])
        
        // Handle selected file
        picker.delegate = self
        opening = true
        
        // Show picker
        self.present(picker, animated: true, completion: nil)
    }
    
    // Save button
    @objc func save(_ sender: Any) {
        // Check if a file is opened
        if currentFile.save() {
            // Update the title
            updateTitle()
            
            // Check to ask for a review
            checkForReview()
        } else {
            // Save document in temp folder
            let file = FileManager.default.temporaryDirectory.appendingPathComponent("source.ml")
            try? currentFile.source.write(to: file, atomically: true, encoding: .utf8)
            
            // Create a document picker
            let picker = UIDocumentPickerViewController(forExporting: [file])
            
            // Handle selected file
            picker.delegate = self
            saving = true
            
            // Show picker
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    // Close button
    @objc func close(_ sender: Any) {
        // Close current file
        if let index = currentIndex {
            // Remove the file at this index
            files.remove(at: index)
            
            // Reset index
            currentIndex = nil
        }
    }
    
    // Open file from url
    func openFile(url: URL) {
        // Open file
        let file = OCamlFile()
        if file.load(from: url) {
            // File loaded
            files.append(file)
            currentIndex = files.count - 1
        } else {
            // Error while opening file
            let alert = UIAlertController(title: "file_error".localized(), message: "file_error_description".localized(), preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "button_ok".localized(), style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // Save file to URL
    func saveFile(to url: URL) {
        // Set URL to file
        currentFile.url = url
        
        // And save the file
        currentFile.save()
        
        // Update the title
        updateTitle()
    }
    
    // Handle selected file
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // Open
        if opening, let url = urls.first {
            openFile(url: url)
        }
        
        // Save
        else if saving, let url = urls.first {
            saveFile(to: url)
        }
    }
    
    // Handle picker cancel
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        self.opening = false
        self.saving = false
    }
    
    // Check for review
    func checkForReview() {
        // Retrieve the number of save and increment it
        let datas = UserDefaults.standard
        let savesCount = datas.integer(forKey: "savesCount") + 1
        datas.set(savesCount, forKey: "savesCount")
        datas.synchronize()
        
        // Check number of saves to ask for a review
        if savesCount == 10 || savesCount == 50 || savesCount % 100 == 0 {
            // Get main app scene
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                // Request review
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
    
}

protocol CodeExecutorDelegate: class {
    
    func execute(_ source: String, show: Bool, completionHandler: @escaping () -> ())

}
