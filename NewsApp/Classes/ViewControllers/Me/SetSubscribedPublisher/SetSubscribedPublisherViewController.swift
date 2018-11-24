//
//  SetSubscribedPublisherViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/24.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class SetSubscribedPublisherViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "SetSubscribedPublisherTableViewCell"
    let cellHeight = 60
    var publisher_array:[JSON] = []
    var subscribed_publisher_array:[JSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func resetContent() {
        super.resetContent()
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Publisher")
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.retrieveData()
    }
    
    func retrieveData() {
        var news_params: [String: Any] = [:]
        news_params["posttype"] = 2 as Any
        
        //get all publishers list
        NetworkManager.instance.requestData(.GET, URLString: "http://127.0.0.1:5000/publisher", parameters: nil, finishedCallback: { (json) in
            if json["returnCode"].intValue == 1 {
                self.publisher_array = json["publisher"].arrayValue
            }
            
            /*******get user's subcribed publishers' list********/
            var params: [String: Any] = [:]
            params["posttype"] = 0 as Any
            params["userid"] = LoginManager.userID as Any
            NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/subscribe", parameters: params) { (json) in
                if json["returnCode"].intValue == 1 {
                    let return_content = json["returnContent"].dictionaryValue
                    self.subscribed_publisher_array = return_content["publisher"]!.arrayValue
                    self.tableView.reloadData()
                }
            }
            /*******get user's subcribed publishers' list********/

            
        })
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.publisher_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SetSubscribedPublisherTableViewCell
        cell.ivChecked.image = UIImage(named: "unchecked")
        self.publisher_array[indexPath.row]["subscribed"] = false
        for subscribed_publisher in self.subscribed_publisher_array {
            if subscribed_publisher.stringValue == self.publisher_array[indexPath.row]["publisherName"].stringValue {
                cell.ivChecked.image = UIImage(named: "checked")
                self.publisher_array[indexPath.row]["subscribed"] = true
                break
            }
        }
        cell.lblTitle.text = self.publisher_array[indexPath.row]["publisherName"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var params: [String: Any] = [:]
        if self.publisher_array[indexPath.row]["subscribed"].boolValue {
            params["posttype"] = 2 as Any
        } else {
            params["posttype"] = 1 as Any
        }
        params["userid"] = LoginManager.userID as Any
        params["publisherid"] = self.publisher_array[indexPath.row]["publisherID"] as Any
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/subscribe", parameters: params) { (json) in
            if json["returnCode"].intValue == 1 {
                let cell = tableView.cellForRow(at: indexPath) as! SetSubscribedPublisherTableViewCell
                if self.publisher_array[indexPath.row]["subscribed"].boolValue {
                    cell.ivChecked.image = UIImage(named: "unchecked")
                } else {
                    cell.ivChecked.image = UIImage(named: "checked")
                }
                
            }
        }
    }

}
