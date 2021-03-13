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

class LearnChapterTableViewController: UITableViewController {
    
    var chapter: LearnChapter? {
        didSet {
            title = chapter?.title.localized()
            tableView.reloadData()
        }
    }
    
    init() {
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove separators
        tableView.separatorStyle = .none
        
        // Register cells
        tableView.register(LearnChapterTitleTableViewCell.self, forCellReuseIdentifier: LearnChapterTitleTableViewCell.identifier)
        tableView.register(LearnChapterParagraphTableViewCell.self, forCellReuseIdentifier: LearnChapterParagraphTableViewCell.identifier)
        tableView.register(LearnChapterCodeTableViewCell.self, forCellReuseIdentifier: LearnChapterCodeTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapter?.elements.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return chapter?.elements[indexPath.row].height() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get element
        guard let element = chapter?.elements[indexPath.row] else { fatalError() }
        
        // Inject in cell
        return (tableView.dequeueReusableCell(withIdentifier: element.cell.identifier, for: indexPath) as! LearnChapterCell).with(element: element, in: tableView)
    }

}
