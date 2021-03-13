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
    
    // File properties
    var currentFile: URL? { didSet { updateTitle() }}
    var edited = false { didSet { updateTitle() }}
    var loading = true
    var opening = false
    var saving = false
    
    // Delegate
    weak var delegate: CodeExecutorDelegate?

    // Load view
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "code".localized()
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "doc.badge.plus"), style: .plain, target: self, action: #selector(open(_:))),
            UIBarButtonItem(image: UIImage(systemName: "arrow.down.doc"), style: .plain, target: self, action: #selector(save(_:))),
            UIBarButtonItem(image: UIImage(systemName: "clear"), style: .plain, target: self, action: #selector(close(_:)))
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Reload content to be sure to have updated colors
        CustomTheme.shared.loadColors()
    }
    
    // Update title
    func updateTitle() {
        navigationItem.title = (currentFile?.lastPathComponent ?? "code".localized()) + (edited ? " (*)" : "")
    }
    
    // Give the OCaml lexer
    func lexerForSource(_ source: String) -> Lexer {
        return OCamlLexer()
    }
    
    // Listen for content change
    func didChangeText(_ syntaxTextView: SyntaxTextView) {
        // Check for loading
        if loading {
            // Mark as loaded
            self.loading = false
        } else {
            // Mark as edited
            self.edited = true
        }
    }
    
    // Get keyboard shortcuts for iPad and Mac
    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: "o", modifierFlags: .command, action: #selector(open(_:))),
            UIKeyCommand(input: "s", modifierFlags: .command, action: #selector(save(_:))),
            UIKeyCommand(input: "r", modifierFlags: .command, action: #selector(execute(_:)))
        ]
    }
    
    // Execute content (play button)
    @objc func execute(_ sender: Any) {
        // Get source code
        let source = self.editor.text
        
        // Disable button while compiling
        //navigationItem.rightBarButtonItem?.isEnabled = false
        
        // Compile it
        delegate?.execute(source) {
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
        if let currentFile = currentFile {
            // Start accessing a security-scoped resource.
            guard currentFile.startAccessingSecurityScopedResource() else { return }
            defer { currentFile.stopAccessingSecurityScopedResource() }
            
            // Save file content
            try? editor.text.write(to: currentFile, atomically: true, encoding: .utf8)
            self.edited = false
            
            // Check to ask for a review
            self.checkForReview()
        } else {
            // Save document in temp folder
            let file = FileManager.default.temporaryDirectory.appendingPathComponent("source.ml")
            try? editor.text.write(to: file, atomically: true, encoding: .utf8)
            
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
        // Clear source code
        self.loading = true
        self.edited = false
        self.editor.text = ""
        
        // Close current file
        self.currentFile = nil
    }
    
    // Open file from url
    func openFile(url: URL) {
        // Start accessing a security-scoped resource.
        guard url.startAccessingSecurityScopedResource() else { return }
        defer { url.stopAccessingSecurityScopedResource() }
        
        // Get URL
        self.currentFile = url
        
        // Open file in editor
        self.loading = true
        self.editor.text = (try? String(contentsOf: url)) ?? ""
        self.edited = false
        self.opening = false
    }
    
    // Save file to URL
    func saveFile(to url: URL) {
        // Start accessing a security-scoped resource.
        guard url.startAccessingSecurityScopedResource() else { return }
        defer { url.stopAccessingSecurityScopedResource() }
        
        // Save URL
        self.currentFile = url
        self.edited = false
        self.saving = false
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
    
    func execute(_ source: String, completionHandler: @escaping () -> ())

}
