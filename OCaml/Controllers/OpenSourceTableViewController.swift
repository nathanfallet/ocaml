//
//  OpenSourceTableViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 09/04/2021.
//

import UIKit

class OpenSourceTableViewController: UITableViewController {
    
    // List of repositories
    let repositories = [
        // The app itself
        [("GroupeMINASTE", "OCaml-iOS")],
        
        // Swift packages
        [
            ("GroupeMINASTE", "DonateViewController"),
            ("twostraws", "Sourceful")
        ],
        
        // Others
        [
            ("ocsigen", "js_of_ocaml")
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "opensource".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Register cells
        tableView.register(AppTableViewCell.self, forCellReuseIdentifier: "appCell")
        
        // Add close button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "button_close".localized(), style: .plain, target: self, action: #selector(close(_:)))
    }
    
    @objc func close(_ sender: UIBarButtonItem) {
        // Dismiss view controller
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? nil : section == 1 ? "opensource_swiftpackages".localized() : "opensource_others".localized()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the repository
        let repo = repositories[indexPath.section][indexPath.row]
        
        // Return the cell
        return (tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as! AppTableViewCell).with(name: "\(repo.0)/\(repo.1)", desc: "opensource_repo_\(repo.1)".localized(), url: "https://github.com/\(repo.0).png")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the repository
        let repo = repositories[indexPath.section][indexPath.row]
        
        // Get URL
        if let url = URL(string: "https://github.com/\(repo.0)/\(repo.1)") {
            UIApplication.shared.open(url)
        }
    }

}
