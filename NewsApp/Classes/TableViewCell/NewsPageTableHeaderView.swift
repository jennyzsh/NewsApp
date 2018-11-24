//
//  NewsPageTableHeaderView.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/22.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class NewsPageTableHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblSubscribe: UILabel!
    var subscribed = false
    var publisherID = -1
    
    override func awakeFromNib() {
        self.lblSubscribe.layer.borderWidth = 1
        self.lblSubscribe.layer.cornerRadius = 3

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapSubscribe))
        self.lblSubscribe.addGestureRecognizer(tap)
    }
    
    func setupLabelSubscribe() {
        if self.subscribed {
            self.lblSubscribe.text = StringUtility.getStringOf(keyName: "Subscribed")
            self.lblSubscribe.layer.borderColor = Color.Gray.cgColor
            self.lblSubscribe.textColor = Color.Gray
        } else {
            self.lblSubscribe.text = StringUtility.getStringOf(keyName: "Subscribe")
            self.lblSubscribe.layer.borderColor = Color.Blue.cgColor
            self.lblSubscribe.textColor = Color.Blue
        }
    }
    
    @objc func didTapSubscribe() {
        if !self.subscribed {
            var params: [String: Any] = [:]
            params["posttype"] = 1 as Any
            params["userid"] = LoginManager.userID as Any
            params["publisherid"] = self.publisherID as Any
            NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/subscribe", parameters: params) { (json) in
                if json["returnCode"].intValue == 1 {
                    self.subscribed = true
                    self.setupLabelSubscribe()
                }
            }
        }
    }
    
}
