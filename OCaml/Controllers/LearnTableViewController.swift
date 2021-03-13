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

class LearnTableViewController: UITableViewController {
    
    weak var delegate: LearnElementSelectionDelegate?

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
        delegate?.selectElement(element)
    }

}

protocol LearnElementSelectionDelegate: class {
    
    func selectElement(_ element: LearnSequenceElement)

}
