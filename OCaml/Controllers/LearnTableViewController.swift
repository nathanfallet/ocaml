//
//  LearnTableViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 05/01/2021.
//

import UIKit

class LearnTableViewController: UITableViewController {

    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = "learn".localized()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Register cells
        tableView.register(LearnTableViewCell.self, forCellReuseIdentifier: "learnCell")
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
        return (tableView.dequeueReusableCell(withIdentifier: "learnCell", for: indexPath) as! LearnTableViewCell).with(model: element)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get element
        let element = OCamlCourse.content[indexPath.section].elements[indexPath.row]
        
        // Open appropriate controller
        if let chapter = element as? LearnChapter {
            // Chapter
            navigationController?.pushViewController(LearnChapterTableViewController(chapter: chapter), animated: true)
        }
    }

}
