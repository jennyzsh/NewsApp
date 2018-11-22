//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/22.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class NewsPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    
    let textCellIdentifier = "NewsPageTextTableViewCell"
    let imageCellIdentifier = "NewsPageImageTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName: textCellIdentifier, bundle: nil), forCellReuseIdentifier: textCellIdentifier)
        self.tableView.register(UINib(nibName: imageCellIdentifier, bundle: nil), forCellReuseIdentifier: imageCellIdentifier)
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! NewsPageTextTableViewCell
        
        return cell
    }

    @IBAction func didPressBtn1(_ sender: UIButton) {
    }
    
    @IBAction func didPressBtn2(_ sender: UIButton) {
    }
}
