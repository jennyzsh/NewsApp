//
//  SubscribeViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 27/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class SubscribeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "SubscribeTableViewCell"
    var refreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        refreshControl.addTarget(self, action: #selector(refreshData),
                                 for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.tableView.addSubview(refreshControl)
//        refreshData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if LoginManager.userID == -1 {
            self.present(LoginViewController(), animated: true, completion: nil)
        }

    }
    
    override func resetContent() {
        super.resetContent()
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Subscribe")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)
    }
    
    @objc func refreshData() {
        
        self.refreshControl.endRefreshing()
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let controller = AddCommentViewController()
//        controller.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 400)
//        controller.willMove(toParentViewController: self)
//        self.view.addSubview(controller.view)
//        self.addChildViewController(controller)
//        controller.didMove(toParentViewController: self)
        
        self.navigationController?.pushViewController(NewsPageViewController(), animated: true)
        
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "asdfaf"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SubscribeTableViewCell
        
        return cell
    }

}
