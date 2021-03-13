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
        preferredDisplayMode = .oneBesideSecondary
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
