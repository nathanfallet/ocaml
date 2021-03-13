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

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Create view
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Get tab bar controller
        if let tabBarController = window?.rootViewController as? TabBarController {
            // Show code tab
            tabBarController.selectedIndex = 1
            
            // Open file in code view controller
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                tabBarController.code.openFile(url: url)
            }
        }
        
        return true
    }
    
    // MARK: - Mac Menu Bar
    
    override func buildMenu(with builder: UIMenuBuilder) {
        // Remove useless items
        builder.remove(menu: .services)
        builder.remove(menu: .format)
        
        // Preferences
        let preferencesCommand = UIKeyCommand(input: ",", modifierFlags: [.command], action: #selector(openPreferences))
        let title = "menuBarItem.preferences".localized()
        preferencesCommand.title = title
        let openPreferences = UIMenu(title: title, image: nil, identifier: UIMenu.Identifier("openPreferences"), options: .displayInline, children: [preferencesCommand])
        builder.insertSibling(openPreferences, afterMenu: .about)
    }
    
    @objc func openPreferences() {
        if let tabBarController = window?.rootViewController as? TabBarController {
            tabBarController.selectedIndex = 2
        }
    }

}

