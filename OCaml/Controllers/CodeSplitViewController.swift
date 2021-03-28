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
        
        // Load controllers
        viewControllers.forEach { controller in
            controller.loadView()
        }
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    // Open file from url
    func openFile(url: URL) {
        // Just delegate to view controller
        codeViewController.openFile(url: url)
    }
    
    func execute(_ source: String, show: Bool, completionHandler: @escaping () -> ()) {
        // Present console
        if show, let navigationController = self.consoleViewController.navigationController {
            self.showDetailViewController(navigationController, sender: nil)
        }
        
        // Compile code
        consoleViewController.execute(source, completionHandler: completionHandler)
    }

}
