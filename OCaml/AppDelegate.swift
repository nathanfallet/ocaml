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
        // Copy url
        var url = url
        
        // If file comes from AirDrop, move it
        if url.deletingLastPathComponent().lastPathComponent == "Inbox" {
            let newURL = url.deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("airdrop-" + url.lastPathComponent)
            let _ = try? FileManager.default.moveItem(at: url, to: newURL)
            url = newURL
        }
        
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
        let preferencesTitle = "menuBarItem.preferences".localized()
        let preferencesCommand = UIKeyCommand(input: ",", modifierFlags: .command, action: #selector(openPreferences(_:)))
        preferencesCommand.title = preferencesTitle
        let openPreferences = UIMenu(title: preferencesTitle, image: nil, identifier: UIMenu.Identifier("openPreferences"), options: .displayInline, children: [preferencesCommand])
        builder.insertSibling(openPreferences, afterMenu: .about)
        
        // File menu
        let openCommand = UIKeyCommand(input: "o", modifierFlags: .command, action: #selector(openFile(_:)))
        openCommand.title = "open".localized()
        let saveCommand = UIKeyCommand(input: "s", modifierFlags: .command, action: #selector(saveFile(_:)))
        saveCommand.title = "save".localized()
        let executeCommand = UIKeyCommand(input: "r", modifierFlags: .command, action: #selector(executeFile(_:)))
        executeCommand.title = "execute".localized()
        let fileMenu = UIMenu(title: "", image: nil, identifier: UIMenu.Identifier("OCamlFile"), options: .displayInline, children: [openCommand, saveCommand, executeCommand])
        builder.insertChild(fileMenu, atStartOfMenu: .file)
    }
    
    @objc func openPreferences(_ sender: Any) {
        if let tabBarController = window?.rootViewController as? TabBarController {
            tabBarController.selectedIndex = 2
        }
    }
    
    @objc func openFile(_ sender: Any) {
        if let tabBarController = window?.rootViewController as? TabBarController {
            tabBarController.selectedIndex = 1
            tabBarController.code.codeViewController.open(sender)
        }
    }
    
    @objc func saveFile(_ sender: Any) {
        if let tabBarController = window?.rootViewController as? TabBarController {
            tabBarController.selectedIndex = 1
            tabBarController.code.codeViewController.save(sender)
        }
    }
    
    @objc func executeFile(_ sender: Any) {
        if let tabBarController = window?.rootViewController as? TabBarController {
            tabBarController.selectedIndex = 1
            tabBarController.code.codeViewController.execute(sender)
        }
    }

}

