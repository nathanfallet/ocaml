//
//  SettingsTableViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIColorPickerViewControllerDelegate {
    
    // Some states
    var currentEditingColor: (String, UIColor)?
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "settings".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Register cells
        tableView.register(EditorColorTableViewCell.self, forCellReuseIdentifier: "editorColorCell")
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "labelCell")
        tableView.register(AppTableViewCell.self, forCellReuseIdentifier: "appCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Reload content to be sure to have updated colors
        CustomTheme.shared.loadColors()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 7 : section == 1 ? 2 : 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "editor_settings".localized() : section == 1 ? "about".localized() : "apps".localized()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Settings
        if indexPath.section == 0 {
            // Editor colors
            if indexPath.row == 0 {
                return (tableView.dequeueReusableCell(withIdentifier: "editorColorCell", for: indexPath) as! EditorColorTableViewCell).with(id: "backgroundColor", current: CustomTheme.shared.backgroundColor)
            } else if indexPath.row == 1 {
                return (tableView.dequeueReusableCell(withIdentifier: "editorColorCell", for: indexPath) as! EditorColorTableViewCell).with(id: "plainColor", current: CustomTheme.shared.plainColor)
            } else if indexPath.row == 2 {
                return (tableView.dequeueReusableCell(withIdentifier: "editorColorCell", for: indexPath) as! EditorColorTableViewCell).with(id: "numberColor", current: CustomTheme.shared.numberColor)
            } else if indexPath.row == 3 {
                return (tableView.dequeueReusableCell(withIdentifier: "editorColorCell", for: indexPath) as! EditorColorTableViewCell).with(id: "stringColor", current: CustomTheme.shared.stringColor)
            } else if indexPath.row == 4 {
                return (tableView.dequeueReusableCell(withIdentifier: "editorColorCell", for: indexPath) as! EditorColorTableViewCell).with(id: "identifierColor", current: CustomTheme.shared.identifierColor)
            } else if indexPath.row == 5 {
                return (tableView.dequeueReusableCell(withIdentifier: "editorColorCell", for: indexPath) as! EditorColorTableViewCell).with(id: "keywordColor", current: CustomTheme.shared.keywordColor)
            } else if indexPath.row == 6 {
                return (tableView.dequeueReusableCell(withIdentifier: "editorColorCell", for: indexPath) as! EditorColorTableViewCell).with(id: "commentColor", current: CustomTheme.shared.commentColor)
            }
            
        }
        // About
        else if indexPath.section == 1 {
            // Name
            if indexPath.row == 0 {
                return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: "developer_text".localized())
            }
            // Donate
            else if indexPath.row == 1 {
                return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: "donate_title".localized())
            }
        }
        // Apps in the same collection
        else if indexPath.section == 2 {
            // Delta: Math helper
            if indexPath.row == 0 {
                return (tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as! AppTableViewCell).with(name: "Delta: Math helper", desc: "delta".localized(), icon: UIImage(named: "Delta"))
            }
            // BaseConverter: All in one
            else if indexPath.row == 1 {
                return (tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as! AppTableViewCell).with(name: "BaseConverter: All in one", desc: "baseconverter".localized(), icon: UIImage(named: "BaseConverter"))
            }
        }
        
        fatalError("Unknown cell!")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Settings
        if indexPath.section == 0 {
            // Editor colors
            if let cell = tableView.cellForRow(at: indexPath) as? EditorColorTableViewCell, let current = cell.currentEditingColor {
                // Save choice
                currentEditingColor = current
                
                // Open color picker
                let picker = UIColorPickerViewController()
                picker.selectedColor = current.1
                picker.supportsAlpha = false
                picker.delegate = self
                present(picker, animated: true, completion: nil)
            }
        }
        // About
        else if indexPath.section == 1 {
            // Name
            if indexPath.row == 0 {
                if let url = URL(string: "https://www.nathanfallet.me/") {
                    UIApplication.shared.open(url)
                }
            }
            // Donate
            else if indexPath.row == 1 {
                present(UINavigationController(rootViewController: CustomDonateViewController()), animated: true, completion: nil)
            }
        }
        // Apps in the same collection
        else if indexPath.section == 2 {
            // Delta: Math helper
            if indexPath.row == 0 {
                if let url = URL(string: "https://apps.apple.com/app/delta-math-helper/id1436506800") {
                    UIApplication.shared.open(url)
                }
            }
            // BaseConverter: All in one
            else if indexPath.row == 1 {
                if let url = URL(string: "https://apps.apple.com/app/baseconverter-all-in-one/id1446344899") {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        // Check if a selection was on, and color was changed
        if let selection = currentEditingColor, selection.1 != viewController.selectedColor {
            // Save new color
            let datas = UserDefaults(suiteName: "group.me.nathanfallet.ocaml") ?? .standard
            datas.setValue(viewController.selectedColor.toInt(), forKey: selection.0)
            datas.synchronize()
            
            // Reload theme and table view
            CustomTheme.shared.loadColors()
            tableView.reloadData()
        }
        
        // Stop any active selection
        currentEditingColor = nil
    }

}
