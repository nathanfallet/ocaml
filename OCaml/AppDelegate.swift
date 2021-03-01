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
            tabBarController.code.openFile(url: url)
        }
        
        return true
    }

}

