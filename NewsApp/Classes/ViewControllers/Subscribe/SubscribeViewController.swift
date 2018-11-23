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
    
    let cellIdentifier = "NewsMenuTableViewCell"
    var refreshControl = UIRefreshControl()
    var news_contents: Dictionary<String, Any> = Dictionary()
    
    
    
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
        } else {
            self.retrieveData()
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
    
    func retrieveData() {
        
        //get user's subscribed publisher list
        var params: [String: Any] = [:]
        params["posttype"] = 0 as Any
        params["userid"] = 10 as Any
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/subscribe", parameters: params) { (json) in
            
            if json["returnCode"] as! Int == 1 {
                let return_content = json["returnContent"] as! Dictionary<String, Any>
                let publisher = (return_content["publisher"] as! NSArray) as Array
                let new_publisher = publisher.map({String(describing: $0)})
                let publisher_string = new_publisher.joined(separator: " ")
                
                /*******get user's subcribed publishers' news********/
                var news_params: [String: Any] = [:]
                news_params["posttype"] = 0 as Any
                news_params["publisher"] = publisher_string as Any
                
                NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/news", parameters: news_params, finishedCallback: { (json) in
                    
                    if json["returnCode"] as! Int == 1 {
                        let news_contents = json["returnContent"] as! Dictionary<String, Any>
                        self.news_contents = news_contents
                        self.tableView.reloadData()
                    }
                })
                /*******get user's subcribed publishers' news********/

            }
        }
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

}
