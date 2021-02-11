//
//  SettingsTableViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
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
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "labelCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "editor_settings".localized() : "about".localized()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Settings
        if indexPath.section == 0 {
            
        }
        // Developer
        else if indexPath.section == 1 {
            // Name
            if indexPath.row == 0 {
                return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: "developer_text".localized())
            }
            // More
            else if indexPath.row == 1 {
                return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: "more".localized())
            }
            // Donate
            else if indexPath.row == 2 {
                return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: "donate_title".localized())
            }
        }
        
        fatalError("Unknown cell!")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Developer
        if indexPath.section == 0 {
            // More
            if indexPath.row == 1 {
                if let url = URL(string: "https://www.groupe-minaste.org/") {
                    UIApplication.shared.open(url)
                }
            }
            // Donate
            else if indexPath.row == 2 {
                present(UINavigationController(rootViewController: CustomDonateViewController()), animated: true, completion: nil)
            }
        }
    }

}
