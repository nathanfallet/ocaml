//
//  LearnSplitViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 01/03/2021.
//

import UIKit

class LearnSplitViewController: UISplitViewController, UISplitViewControllerDelegate, LearnElementSelectionDelegate {
    
    let listViewController = LearnTableViewController()
    let chapterViewController = LearnChapterTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Give delegates
        listViewController.delegate = self
        
        // Create navigation controllers
        let leftNavigationController = UINavigationController(rootViewController: listViewController)
        let rightNavigationController = UINavigationController(rootViewController: chapterViewController)
        
        // Assign them
        viewControllers = [leftNavigationController, rightNavigationController]
        
        // Some configuration
        preferredDisplayMode = .allVisible
        delegate = self
        primaryBackgroundStyle = .sidebar
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    func selectElement(_ element: LearnSequenceElement) {
        // Chapter
        if let chapter = element as? LearnChapter, let navigationVC = chapterViewController.navigationController {
            // Set content
            chapterViewController.chapter = chapter
            showDetailViewController(navigationVC, sender: nil)
        }
    }

}
