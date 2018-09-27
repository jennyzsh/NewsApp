//
//  SelectThemeColorViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 27/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class SelectThemeColorViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier = "SelectThemeColorTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func resetContent() {
        super.resetContent()
        self.navigationController?.navigationBar.topItem?.title = StringUtility.getStringOf(keyName: "SelectThemeColor")
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Color.themeColorList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SelectThemeColorTableViewCell
        cell.backgroundColor = Color.themeColorList[indexPath.row]
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Color.themeColor = ThemeColor(rawValue: indexPath.row)!
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationKey.ThemeColor_Did_Change_Notify), object: nil)
    }
}
