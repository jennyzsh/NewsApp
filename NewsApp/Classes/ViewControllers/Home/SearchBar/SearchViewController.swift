//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 28/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

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
        
        //set up Navigation Bar TitleView
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Search")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)
        
        //set up Navigation Bar Right BarButton Item
        let dismiss = UIBarButtonItem(title: "XXXX", style: .plain, target: self, action: #selector(SearchViewController.didPressRightBarButton))
        dismiss.tintColor = Color.White
        self.setNavigationBarRightButtonItem(dismiss)
        
        //set up Navigation Bar Left BarButton Item
        let back = UIBarButtonItem(title: "<-", style: .plain, target: self, action: #selector(SearchViewController.didPressLeftBarButton))
        back.tintColor = Color.White
        self.setNavigationBarLeftButtonItem(back)

        self.setupSearchBar()
    }
    
    @objc func refreshData() {
        
        self.refreshControl.endRefreshing()
    }
    
    func retrieveData() {
        //get all news
        var news_params: [String: Any] = [:]
        news_params["posttype"] = 1 as Any
        news_params["keyword"] = self.navigationItem.searchController?.searchBar.text as! Any
        
        print("hahahahaha")
        print(news_params)
        
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/news", parameters: news_params, finishedCallback: { (json) in
            
            if json["returnCode"].intValue == 1 {
                let news_contents = json["returnContent"].arrayValue
                self.news_contents = news_contents
                self.tableView.reloadData()
            }
        })
        
    }
    
    func setupSearchBar() {
        var searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Now"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.navigationItem.searchController = searchController
        searchController.searchBar.tintColor = Color.White
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        //search news by keyword
        var news_params: [String: Any] = [:]
        news_params["posttype"] = 1 as Any
        news_params["keyword"] = searchBar.text! as Any
        
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/news", parameters: news_params, finishedCallback: { (json) in
            
            if json["returnCode"].intValue == 1 {
                let news_contents = json["returnContent"].arrayValue
                self.news_contents = news_contents
                self.tableView.reloadData()
            }
        })

    }
    
    @objc func didPressRightBarButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressLeftBarButton() {
        self.dismiss(animated: true, completion: nil)
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
