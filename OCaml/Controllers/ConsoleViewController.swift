//
//  ConsoleViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit

class ConsoleViewController: UIViewController {
    
    // Executor
    let executor = OCamlExecutor()
    
    // Views
    let output = UITextView()
    let loading = UIActivityIndicatorView()

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
        
        // Add loading indicator
        view.addSubview(loading)
        loading.translatesAutoresizingMaskIntoConstraints = false
        loading.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        loading.hidesWhenStopped = true
    }
    
    func execute(_ source: String, completionHandler: @escaping () -> ()) {
        // Start loading
        self.loading.startAnimating()
        self.output.text = ""
        
        // Compile source async
        DispatchQueue.global().async {
            self.executor.compile(source: source) { javascript, error in
                // Check if it was compiled
                if let javascript = javascript {
                    // Execute it
                    self.executor.run(javascript: javascript) { entries in
                        // Process entries
                        let output = entries.map{ $0.description }.joined(separator: "\n")
                        
                        // Present output
                        DispatchQueue.main.async {
                            self.loading.stopAnimating()
                            self.output.text = output
                            completionHandler()
                        }
                    }
                } else {
                    // Handler errors
                    let alert = UIAlertController(title: "error".localized(), message: nil, preferredStyle: .alert)
                    switch error {
                        case .fromJS(let jsError):
                            alert.message = jsError
                        default:
                            alert.message = "error_unknown".localized()
                    }
                    alert.addAction(UIAlertAction(title: "button_ok".localized(), style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }

}
