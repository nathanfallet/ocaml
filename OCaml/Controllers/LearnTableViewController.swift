//
//  LearnTableViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit

class LearnTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "learn".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Register cells
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "labelCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return OCamlCourse.content.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OCamlCourse.content[section].elements.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return OCamlCourse.content[section].title.localized()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get element
        let element = OCamlCourse.content[indexPath.section].elements[indexPath.row]
        
        // Inject in cell
        return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: element.title.localized())
    }

}
