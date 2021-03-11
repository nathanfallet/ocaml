//
//  CodeSplitViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 11/03/2021.
//

import UIKit

class CodeSplitViewController: UISplitViewController, UISplitViewControllerDelegate, CodeExecutorDelegate {

    let codeViewController = CodeViewController()
    let consoleViewController = ConsoleViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Give delegates
        codeViewController.delegate = self
        
        // Create navigation controllers
        let leftNavigationController = UINavigationController(rootViewController: codeViewController)
        let rightNavigationController = UINavigationController(rootViewController: consoleViewController)
        
        // Assign them
        viewControllers = [leftNavigationController, rightNavigationController]
        
        // Some configuration
        preferredDisplayMode = .oneBesideSecondary
        preferredPrimaryColumnWidthFraction = 0.5
        maximumPrimaryColumnWidth = view.bounds.size.width
        delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    // Open file from url
    func openFile(url: URL) {
        // Just delegate to view controller
        codeViewController.openFile(url: url)
    }
    
    func execute(_ source: String, completionHandler: @escaping () -> ()) {
        // Present console
        if let navigationController = self.consoleViewController.navigationController {
            self.showDetailViewController(navigationController, sender: nil)
        }
        
        // Compile code
        consoleViewController.execute(source, completionHandler: completionHandler)
    }

}
