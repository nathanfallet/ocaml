//
//  AppDelegate.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

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

