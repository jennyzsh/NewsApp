//
//  NoteViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 27/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class NoteViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let headerCellIdentifier = "NoteHeaderTableViewCell"
    var tableViewDataIndicator = [false, false, false]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: headerCellIdentifier, bundle: nil), forCellReuseIdentifier: headerCellIdentifier)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func resetContent() {
        super.resetContent()
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Note")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)

    }
    
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewDataIndicator[section] {
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier, for: indexPath) as! NoteHeaderTableViewCell
            cell.lblTitle.text = "Title"
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "Cell"
            return cell
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewDataIndicator[indexPath.section] = !tableViewDataIndicator[indexPath.section]
        let sections = IndexSet.init(integer: indexPath.section)
        tableView.reloadSections(sections, with: .none)
    }
    
}
