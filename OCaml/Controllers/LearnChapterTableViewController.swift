//
//  LearnChapterTableViewController.swift
//  OCaml
//
//  Created by Nathan FALLET on 06/01/2021.
//

import UIKit

class LearnChapterTableViewController: UITableViewController {
    
    let chapter: LearnChapter
    
    init(chapter: LearnChapter) {
        self.chapter = chapter
        
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation bar
        title = chapter.title.localized()
        
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
        return chapter.elements.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get element
        let element = chapter.elements[indexPath.row]
        
        // Inject in cell
        return (tableView.dequeueReusableCell(withIdentifier: element.cell.identifier, for: indexPath) as! LearnChapterCell).with(element: element, in: tableView)
    }

}
