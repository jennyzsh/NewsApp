//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "NewsMenuTableViewCell"
    var refreshControl = UIRefreshControl()
    var news_contents: Dictionary<String, Any> = Dictionary()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        refreshControl.addTarget(self, action: #selector(refreshData),
                                 for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "下拉刷新数据")
        self.tableView.addSubview(refreshControl)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.retrieveData()
    }
    
    @objc func refreshData() {
        
        self.refreshControl.endRefreshing()
    }
    
    override func resetContent() {
        super.resetContent()
     
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Home")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)
        
    }
    
    func retrieveData() {
        //get all news
        var news_params: [String: Any] = [:]
        news_params["posttype"] = 2 as Any
        
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/news", parameters: news_params, finishedCallback: { (json) in
            
            if json["returnCode"] as! Int == 1 {
                let news_contents = json["returnContent"] as! Dictionary<String, Any>
                self.news_contents = news_contents
                self.tableView.reloadData()
            }
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let navController = UINavigationController(rootViewController: SearchViewController())
        self.present(navController, animated: true, completion: nil)
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsID = Array(self.news_contents.keys)[indexPath.row]
        let news_dic = self.news_contents[newsID] as! [String: Any]
        let newsPageVC = NewsPageViewController()
        newsPageVC.newsID = newsID
        newsPageVC.news_dic = news_dic
        self.navigationController?.pushViewController(newsPageVC, animated: true)
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news_contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NewsMenuTableViewCell
        let newsID = Array(self.news_contents.keys)[indexPath.row]
        let news_dic = self.news_contents[newsID] as! [String:Any]
        cell.lblTitle.text = news_dic["title"] as! String
        cell.lblPublisher.text = String(format: StringUtility.getStringOf(keyName: "PublisherStmt"), news_dic["publisher"] as! String)
        cell.lblAuthor.text =  String(format: StringUtility.getStringOf(keyName: "AuthorStmt"), news_dic["author"] as! String)
        cell.lblTime.text = news_dic["time"] as! String
        cell.lblLikeNum.text = String(format: StringUtility.getStringOf(keyName: "LikeNum"), news_dic["like_num"] as! Int)
        cell.lblDislikeNum.text = String(format: StringUtility.getStringOf(keyName: "DislikeNum"), news_dic["dislike_num"] as! Int)
        if news_dic["thumbnail"] != nil {
            cell.setImageContent(with: news_dic["thumbnail"] as! String)
            cell.ivThumbnailConstraintW.constant = 150
        } else {
            cell.ivThumbnailConstraintW.constant = 0
        }
        return cell
    }
    
    
    
    
    
    //MARK: For Testing
    @IBAction func didPressIncreaseBadge(_ sender: UIButton) {
        BadgeManager.applicationIconBadgeNumber += 1
    }
    
    @IBAction func didPressResetBadge(_ sender: UIButton) {
        BadgeManager.resetAppIconBadgeNumber()
    }
    

}
