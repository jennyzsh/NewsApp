//
//  SubscribeViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 27/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubscribeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "NewsMenuTableViewCell"
    var refreshControl = UIRefreshControl()
    var news_contents: [JSON] = []
    
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
        params["userid"] = LoginManager.userID as Any
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/subscribe", parameters: params) { (json) in
            
            if json["returnCode"].intValue == 1 {
                let return_content = json["returnContent"].dictionaryValue
                let publisher = return_content["publisher"]?.arrayValue
                var publisher_string = ""
                if publisher?.count != 0 {
                    for item in publisher! {
                        publisher_string.append(item.stringValue)
                        publisher_string.append(" ")
                    }
                }
                
                /*******get user's subcribed publishers' news********/
                var news_params: [String: Any] = [:]
                news_params["posttype"] = 0 as Any
                news_params["publisher"] = publisher_string as Any
                
                NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/news", parameters: news_params, finishedCallback: { (json) in
                    if json["returnCode"].intValue == 1 {
                        self.news_contents = json["returnContent"].arrayValue
                        self.tableView.reloadData()
                    }
                })
                /*******get user's subcribed publishers' news********/

            }
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsID = self.news_contents[indexPath.row]["newsID"].intValue
        let news_dic = self.news_contents[indexPath.row]
        let newsPageVC = NewsPageViewController()
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
        let newsID = self.news_contents[indexPath.row]["newsID"].intValue
        cell.lblTitle.text = self.news_contents[indexPath.row]["title"].stringValue
        cell.lblPublisher.text = String(format: StringUtility.getStringOf(keyName: "PublisherStmt"), self.news_contents[indexPath.row]["publisher"].stringValue)
        cell.lblAuthor.text =  String(format: StringUtility.getStringOf(keyName: "AuthorStmt"), self.news_contents[indexPath.row]["author"].stringValue)
        cell.lblTime.text = self.news_contents[indexPath.row]["time"].stringValue
        cell.lblLikeNum.text = String(format: StringUtility.getStringOf(keyName: "LikeNum"), self.news_contents[indexPath.row]["like_num"].intValue)
        cell.lblDislikeNum.text = String(format: StringUtility.getStringOf(keyName: "DislikeNum"), self.news_contents[indexPath.row]["dislike_num"].intValue)
        if self.news_contents[indexPath.row]["thumbnail"] != nil {
            cell.setImageContent(with: self.news_contents[indexPath.row]["thumbnail"].stringValue)
            cell.ivThumbnailConstraintW.constant = 150
        } else {
            cell.ivThumbnailConstraintW.constant = 0
        }
        return cell
    }

}
