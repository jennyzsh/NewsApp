//
//  ViewCommentViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/25.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewCommentViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "ViewCommentTableViewCell"
    var newsID = -1
    var comment_array:[JSON] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.retrieveData()
    }
    
    override func resetContent() {
        super.resetContent()
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Comment")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)
        
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backToPrevious))
        back.tintColor = Color.White
        self.setNavigationBarLeftButtonItem(back)
    }
    
    @objc func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func retrieveData() {
        var params: [String: Any] = [:]
        params["posttype"] = 0 as Any
        params["newsid"] = self.newsID as Any
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/getinfo", parameters: params) { (json) in
            if json["returnCode"].intValue == 1 {
                self.comment_array = json["returnContent"].arrayValue
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comment_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ViewCommentTableViewCell
        cell.lblContent.text = self.comment_array[indexPath.row]["comment"].stringValue
        cell.lblUser.text = String(format: StringUtility.getStringOf(keyName: "UserID"), self.comment_array[indexPath.row]["userID"].intValue)
        return cell
    }

}
