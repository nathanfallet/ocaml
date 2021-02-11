//
//  TabBarController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    // Subviews
    let learn = LearnTableViewController()
    let code = CodeViewController()
    let about = SettingsTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create navigations
        let learnNav = UINavigationController(rootViewController: learn)
        let codeNav = UINavigationController(rootViewController: code)
        let aboutNav = UINavigationController(rootViewController: about)
        
        // Set items
        learnNav.tabBarItem = UITabBarItem(title: "learn".localized(), image: UIImage(systemName: "book"), tag: 0)
        codeNav.tabBarItem = UITabBarItem(title: "code".localized(), image: UIImage(systemName: "chevron.left.slash.chevron.right"), tag: 1)
        aboutNav.tabBarItem = UITabBarItem(title: "settings".localized(), image: UIImage(systemName: "gearshape"), tag: 2)

        // Set controllers
        viewControllers = [learnNav, codeNav, aboutNav]
    }

}
