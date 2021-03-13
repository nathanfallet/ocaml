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

class TabBarController: UITabBarController {
    
    // Subviews
    let learn = LearnSplitViewController()
    let code = CodeSplitViewController()
    let about = SettingsTableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create navigations
        let aboutNav = UINavigationController(rootViewController: about)
        
        // Set items
        learn.tabBarItem = UITabBarItem(title: "learn".localized(), image: UIImage(systemName: "book"), tag: 0)
        code.tabBarItem = UITabBarItem(title: "code".localized(), image: UIImage(systemName: "chevron.left.slash.chevron.right"), tag: 1)
        aboutNav.tabBarItem = UITabBarItem(title: "settings".localized(), image: UIImage(systemName: "gearshape"), tag: 2)

        // Set controllers
        viewControllers = [learn, code, aboutNav]
    }

}
