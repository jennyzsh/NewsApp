//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/22.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsPageViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var vAddComment: UIView!
    @IBOutlet weak var vCommentArea: UIView!
    @IBOutlet weak var tvComment: UITextView!
    @IBOutlet weak var btnAddComment: UIButton!
    
    var news_dic: JSON!
    var content_array: JSON!
    var subscribed = false
    
    
    let headerHeight = CGFloat(150)
    let textCellIdentifier = "NewsPageTextTableViewCell"
    let imageCellIdentifier = "NewsPageImageTableViewCell"
    let newsHeaderCellIdentifier = "NewsPageTableHeaderView"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveData()
        self.content_array = self.news_dic["content"]
        self.setupLayout()
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName: textCellIdentifier, bundle: nil), forCellReuseIdentifier: textCellIdentifier)
        self.tableView.register(UINib(nibName: imageCellIdentifier, bundle: nil), forCellReuseIdentifier: imageCellIdentifier)
        self.tableView.register(UINib(nibName: newsHeaderCellIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: newsHeaderCellIdentifier)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func resetContent() {
        super.resetContent()
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  "News Page"
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)
        
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(backToPrevious))
        back.tintColor = Color.White
        self.setNavigationBarLeftButtonItem(back)
    }
    
    func retrieveData() {
        //get user's subcribed publishers' list
        var params: [String: Any] = [:]
        params["posttype"] = 0 as Any
        params["userid"] = LoginManager.userID as Any
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/subscribe", parameters: params) { (json) in
            if json["returnCode"].intValue == 1 {
                let subscribed_publisher_array = json["returnContent"]["publisher"].arrayValue
                for subscribed_publisher in subscribed_publisher_array {
                    if self.news_dic["publisher"].stringValue == subscribed_publisher.stringValue {
                        self.subscribed = true
                        break
                    }
                }
            }
            self.tableView.reloadData()
        }

    }
    
    func setupLayout() {
        self.btn1.setTitle(StringUtility.getStringOf(keyName: "AddComment"), for: .normal)
        self.btn2.setTitle(StringUtility.getStringOf(keyName: "ViewComment"), for: .normal)
        self.btnAddComment.setTitle(StringUtility.getStringOf(keyName: "Send"), for: .normal)
        self.vAddComment.isHidden = true
        self.tvComment.layer.borderWidth = 1
        self.tvComment.layer.borderColor = Color.Gray.cgColor
        self.tvComment.layer.cornerRadius = 5
        
        let tapToDismissCommentView = UITapGestureRecognizer(target: self, action: #selector(dismissCommentView))
        self.vAddComment.addGestureRecognizer(tapToDismissCommentView)
    }
    
    @objc func dismissCommentView() {
        self.view.endEditing(true)
        self.vAddComment.isHidden = true
    }
    
    @objc func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.content_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.content_array[indexPath.row]["type"].stringValue == "text" {
            let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! NewsPageTextTableViewCell
            cell.lblContent.text = self.content_array[indexPath.row]["content"].stringValue
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: imageCellIdentifier, for: indexPath) as! NewsPageImageTableViewCell
            cell.setImageContent(with: self.content_array[indexPath.row]["content"].stringValue)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: newsHeaderCellIdentifier) as! NewsPageTableHeaderView
        header.lblTitle.text = self.news_dic["title"].stringValue
        header.lblPublisher.text = String(format: StringUtility.getStringOf(keyName: "PublisherStmt"), self.news_dic["publisher"].stringValue)
        header.lblAuthor.text = String(format: StringUtility.getStringOf(keyName: "AuthorStmt"), self.news_dic["author"].stringValue)
        header.lblTime.text = self.news_dic["time"].stringValue
        header.subscribed = self.subscribed
        header.publisherID = self.news_dic["publisherID"].intValue
        header.setupLabelSubscribe()
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }

    @IBAction func didPressBtn1(_ sender: UIButton) {
        self.vAddComment.isHidden = false
    }
    
    @IBAction func didPressBtn2(_ sender: UIButton) {
        let vc = ViewCommentViewController()
        vc.newsID = self.news_dic["newsID"].intValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressBtnAddComment(_ sender: UIButton) {
        var params: [String: Any] = [:]
        params["posttype"] = 0 as Any
        params["userid"] = LoginManager.userID as Any
        params["newsid"] = self.news_dic["newsID"] as Any
        params["comment"] = self.tvComment.text! as Any
        
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/comment", parameters: params, finishedCallback: { (json) in
            
            if json["returnCode"].intValue == 1 {
                AlertUtility.presentOneButtonSimpleAlert(title: StringUtility.getStringOf(keyName: "AddCommentAlertTitle"), msg: StringUtility.getStringOf(keyName: "AddCommentAlertSuccessMsg"), buttonTitle: StringUtility.getStringOf(keyName: "Confirm"), callback: { (action) in
                    self.tvComment.text = ""
                    self.dismissCommentView()
                })
            }
        })
    }
    
    
}
