//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/22.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsPageViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vAddComment: UIView!
    @IBOutlet weak var vCommentArea: UIView!
    @IBOutlet weak var tvComment: UITextView!
    @IBOutlet weak var btnAddComment: UIButton!
    @IBOutlet weak var tfAddComment: UITextField!
    @IBOutlet weak var btnViewComment: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnDislike: UIButton!
    
    var news_dic: JSON!
    var content_array: JSON!
    var subscribed = false
    var newsSaved = false
    var newsLiked = false
    var newsDisliked = false
    
    
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
        
        //get user's saved news, liked news, disliked news
        var info_params: [String: Any] = [:]
        info_params["posttype"] = 1 as Any
        info_params["userid"] = LoginManager.userID as Any
        info_params["newsid"] = self.news_dic["newsID"] as Any

        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/getinfo", parameters: info_params) { (json) in
            if json["returnCode"].intValue == 1 {
                let content = json["returnContent"].dictionaryValue
                let savedNews = content["savedNews"]?.arrayValue
                let dislikedNews = content["dislikedNews"]?.arrayValue
                let likedNews = content["likedNews"]?.arrayValue
                if savedNews?.count != 0 {
                    self.btnSave.setImage(UIImage(named: "star_fill"), for: .normal)
                    self.newsSaved = true
                } else {
                    self.btnSave.setImage(UIImage(named: "star"), for: .normal)
                    self.newsSaved = false
                }
                if dislikedNews?.count != 0 {
                    self.btnDislike.setImage(UIImage(named: "dislike_fill"), for: .normal)
                    self.newsDisliked = true
                } else {
                    self.btnDislike.setImage(UIImage(named: "dislike"), for: .normal)
                    self.newsDisliked = false
                }
                if likedNews?.count != 0 {
                    self.btnLike.setImage(UIImage(named: "like_fill"), for: .normal)
                    self.newsLiked = true
                } else {
                    self.btnLike.setImage(UIImage(named: "like"), for: .normal)
                    self.newsLiked = false
                }
            }
        }

    }
    
    func setupLayout() {
        self.btnAddComment.setTitle(StringUtility.getStringOf(keyName: "Send"), for: .normal)
        self.vAddComment.isHidden = true
        self.tvComment.layer.borderWidth = 1
        self.tvComment.layer.borderColor = Color.Gray.cgColor
        self.tvComment.layer.cornerRadius = 5
        
        let tapToDismissCommentView = UITapGestureRecognizer(target: self, action: #selector(dismissCommentView))
        self.vAddComment.addGestureRecognizer(tapToDismissCommentView)
        
        self.tfAddComment.placeholder = StringUtility.getStringOf(keyName: "AddComment")
        self.btnViewComment.setImage(UIImage(named: "comment"), for: .normal)
        self.btnSave.setImage(UIImage(named: "star"), for: .normal)
        self.btnLike.setImage(UIImage(named: "like"), for: .normal)
        self.btnDislike.setImage(UIImage(named: "dislike"), for: .normal)
    }
    
    @objc func dismissCommentView() {
        self.view.endEditing(true)
        self.vAddComment.isHidden = true
    }
    
    @objc func backToPrevious() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.vAddComment.resignFirstResponder()
        self.vAddComment.isHidden = false
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
    
    @IBAction func didPressBtnAddComment(_ sender: UIButton) {
        var params: [String: Any] = [:]
        params["posttype"] = 0 as Any
        params["userid"] = LoginManager.userID as Any
        params["newsid"] = self.news_dic["newsID"] as Any
        params["comment"] = self.tvComment.text! as Any
        
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/comment", parameters: params, finishedCallback: { (json) in
            
            if json["returnCode"].intValue == 1 {
                AlertUtility.presentOneButtonSimpleAlert(title: StringUtility.getStringOf(keyName: "AlertTitle"), msg: StringUtility.getStringOf(keyName: "AddCommentAlertSuccessMsg"), buttonTitle: StringUtility.getStringOf(keyName: "Confirm"), callback: { (action) in
                    self.tvComment.text = ""
                    self.dismissCommentView()
                })
            }
        })
    }
    
    @IBAction func didPressBtnViewComment(_ sender: UIButton) {
        let vc = ViewCommentViewController()
        vc.newsID = self.news_dic["newsID"].intValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didPressBtnSave(_ sender: UIButton) {
        var url = ""
        if self.newsSaved {
            url = "http://127.0.0.1:5000/deleteComment"
        } else {
            url = "http://127.0.0.1:5000/comment"
        }
        
        var params: [String: Any] = [:]
        params["posttype"] = 3 as Any
        params["userid"] = LoginManager.userID as Any
        params["newsid"] = self.news_dic["newsID"] as Any
        NetworkManager.instance.requestData(.POST, URLString: url, parameters: params, finishedCallback: { (json) in
            if json["returnCode"].intValue == 1 {
                if self.newsSaved {
                    self.btnSave.setImage(UIImage(named: "star"), for: .normal)
                } else {
                    self.btnSave.setImage(UIImage(named: "star_fill"), for: .normal)
                }
                self.newsSaved = !self.newsSaved
            }
        })
    }
    
    @IBAction func didPressBtnLike(_ sender: UIButton) {
        var url = ""
        if self.newsLiked {
            url = "http://127.0.0.1:5000/deleteComment"
        } else {
            url = "http://127.0.0.1:5000/comment"
        }
        
        var params: [String: Any] = [:]
        params["posttype"] = 1 as Any
        params["userid"] = LoginManager.userID as Any
        params["newsid"] = self.news_dic["newsID"] as Any
        NetworkManager.instance.requestData(.POST, URLString: url, parameters: params, finishedCallback: { (json) in
            if json["returnCode"].intValue == 1 {
                if self.newsLiked {
                    self.btnLike.setImage(UIImage(named: "like"), for: .normal)
                } else {
                    self.btnLike.setImage(UIImage(named: "like_fill"), for: .normal)
                }
                self.newsLiked = !self.newsLiked
            }
        })
    }
    
    @IBAction func didPressBtnDislike(_ sender: UIButton) {
        var url = ""
        if self.newsDisliked {
            url = "http://127.0.0.1:5000/deleteComment"
        } else {
            url = "http://127.0.0.1:5000/comment"
        }
        
        var params: [String: Any] = [:]
        params["posttype"] = 2 as Any
        params["userid"] = LoginManager.userID as Any
        params["newsid"] = self.news_dic["newsID"] as Any
        NetworkManager.instance.requestData(.POST, URLString: url, parameters: params, finishedCallback: { (json) in
            if json["returnCode"].intValue == 1 {
                if self.newsDisliked {
                    self.btnDislike.setImage(UIImage(named: "dislike"), for: .normal)
                } else {
                    self.btnDislike.setImage(UIImage(named: "dislike_fill"), for: .normal)
                }
                self.newsDisliked = !self.newsDisliked
            }
        })
    }
}
