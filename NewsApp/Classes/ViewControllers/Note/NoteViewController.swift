//
//  NoteViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 27/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class NoteViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    let headerCellIdentifier = "NoteHeaderTableViewCell"
    let newsCellIdentifier = "NewsMenuTableViewCell"
    let savedPassageCellIdentifier = "SavedPassageTableViewCell"
    var tableViewDataIndicator = [false, false, false]
    var tableViewHeaders = [String]()
    var savedNewsContent:[JSON] = []
    var savedPassageContent = Array<Any>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: headerCellIdentifier, bundle: nil), forCellReuseIdentifier: headerCellIdentifier)
        self.tableView.register(UINib(nibName: newsCellIdentifier, bundle: nil), forCellReuseIdentifier: newsCellIdentifier)
        self.tableView.register(UINib(nibName: savedPassageCellIdentifier, bundle: nil), forCellReuseIdentifier: savedPassageCellIdentifier)
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableViewHeaders = [StringUtility.getStringOf(keyName: "SavedNews"), StringUtility.getStringOf(keyName: "SavedPassage")]

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.retrieveData()
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
    
    func retrieveData() {
        //get all news
        var news_params: [String: Any] = [:]
        news_params["posttype"] = 2 as Any
        news_params["userid"] = LoginManager.userID as Any
        
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/getinfo", parameters: news_params, finishedCallback: { (json) in
            
            if json["returnCode"].intValue == 1 {
                let news_contents = json["returnContent"].dictionaryValue
                self.savedNewsContent = news_contents["savedNewsDetail"]!.arrayValue
                self.tableView.reloadData()
            }
        })
        
        //get saved passage
        self.savedPassageContent = DatabaseManager.shared.retrieveSavedPassage()
    }
    
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewHeaders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewDataIndicator[section] {
            if section == 0 {
                return self.savedNewsContent.count + 1
            } else if section == 1 {
                return self.savedPassageContent.count + 1
            }
            return 3
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellIdentifier, for: indexPath) as! NoteHeaderTableViewCell
            cell.lblTitle.text = self.tableViewHeaders[indexPath.section]
            return cell
        } else {
            let dataIndex = indexPath.row - 1
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentifier, for: indexPath) as! NewsMenuTableViewCell
                let newsID = self.savedNewsContent[dataIndex]["newsID"].intValue
                cell.lblTitle.text = self.savedNewsContent[dataIndex]["title"].stringValue
                cell.lblPublisher.text = String(format: StringUtility.getStringOf(keyName: "PublisherStmt"), self.savedNewsContent[dataIndex]["publisher"].stringValue)
                cell.lblAuthor.text =  String(format: StringUtility.getStringOf(keyName: "AuthorStmt"), self.savedNewsContent[dataIndex]["author"].stringValue)
                cell.lblTime.text = self.savedNewsContent[dataIndex]["time"].stringValue
                cell.lblLikeNum.text = String(format: StringUtility.getStringOf(keyName: "LikeNum"), self.savedNewsContent[dataIndex]["like_num"].intValue)
                cell.lblDislikeNum.text = String(format: StringUtility.getStringOf(keyName: "DislikeNum"), self.savedNewsContent[dataIndex]["dislike_num"].intValue)
                if self.savedNewsContent[dataIndex]["thumbnail"] != nil {
                    cell.setImageContent(with: self.savedNewsContent[dataIndex]["thumbnail"].stringValue)
                    cell.ivThumbnailConstraintW.constant = 150
                } else {
                    cell.ivThumbnailConstraintW.constant = 0
                }
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: savedPassageCellIdentifier, for: indexPath) as! SavedPassageTableViewCell
                let dic = self.savedPassageContent[dataIndex] as! [String: Any]
                cell.lblPassage.text = dic["passage"] as! String
                cell.lblTitle.text = dic["title"] as! String
                let tap = MyTapGestureRecognizer(target: self, action: #selector(didPressBtnDelete(sender:)))
                cell.btnDelete.addGestureRecognizer(tap)
                tap.id = dic["id"] as! Int
                tap.index = dataIndex
                return cell
            } else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "Cell"
                return cell
            }
        }
    }
    
    @objc func didPressBtnDelete(sender: MyTapGestureRecognizer) {
        DatabaseManager.shared.deletePassage(ID: Int32(sender.id))
        self.savedPassageContent.remove(at: sender.index)
        self.tableView.reloadData()
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableViewDataIndicator[indexPath.section] = !tableViewDataIndicator[indexPath.section]
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        } else {
            if indexPath.section == 0 {
                let dataIndex = indexPath.row - 1
                let newsID = self.savedNewsContent[dataIndex]["newsID"].intValue
                let news_dic = self.savedNewsContent[dataIndex]
                let newsPageVC = NewsPageViewController()
                newsPageVC.news_dic = news_dic
                self.navigationController?.pushViewController(newsPageVC, animated: true)
            } else if indexPath.section == 1 {
                
            }
            
        }
    }
    
}


class MyTapGestureRecognizer: UITapGestureRecognizer {
    var id = -1
    var index = -1
}
