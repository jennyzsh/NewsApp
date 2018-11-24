//
//  MeViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

enum SettingContent: Int {
    case Subscriber = 0
    case Language
    case ThemeColor
    case SettingNum
}

class MeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblDearUser: UILabel!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var vTableContainer: UIView!
    @IBOutlet weak var tableContainerConstraintH: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "MeTableViewCell"
    let cellHeight = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    override func resetContent() {
        super.resetContent()
        
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Me")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)
        
        self.lblDearUser.text = StringUtility.getStringOf(keyName: "DearUser")
        self.lblUserId.text = String(format: StringUtility.getStringOf(keyName: "UserID"), LoginManager.userID)
        
        self.vTableContainer.layer.borderWidth = 1
        self.vTableContainer.layer.borderColor = Color.Gray.cgColor
        self.vTableContainer.layer.cornerRadius = 5
        self.tableContainerConstraintH.constant = CGFloat(self.cellHeight) * CGFloat(SettingContent.SettingNum.rawValue) + 20
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func selectLanguage() {
        let actionSheet = UIAlertController.init(title: StringUtility.getStringOf(keyName: "SelectLang"), message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: StringUtility.getStringOf(keyName: "Cancel"), style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: StringUtility.getStringOf(keyName: "English"), style: .default, handler: { (action) in
            LanguageUtility.lang = .en
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationKey.Language_Did_Change_Notify), object: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: StringUtility.getStringOf(keyName: "Simplified_Chinese"), style: .default, handler: { (action) in
            LanguageUtility.lang = .sc
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationKey.Language_Did_Change_Notify), object: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: StringUtility.getStringOf(keyName: "Traditional_Chinese"), style: .default, handler: { (action) in
            LanguageUtility.lang = .tc
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationKey.Language_Did_Change_Notify), object: nil)
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func selectThemeColor() {
        self.navigationController?.pushViewController(SelectThemeColorViewController(), animated: true)
    }
    
    @IBAction func didClickBtnSelectLang(_ sender: UIButton) {
        self.selectLanguage()
    }
    
    @IBAction func didPressBtnSelectThemeColor(_ sender: UIButton) {
        self.selectThemeColor()
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(SetSubscribedPublisherViewController(), animated: true)
        case 1:
            self.selectLanguage()
        case 2:
            self.selectThemeColor()
        default:
            break
        }
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingContent.SettingNum.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MeTableViewCell
        cell.lblTitle.text = StringUtility.getStringOf(keyName: String(format: "MeTableItem_%i", indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(cellHeight)
    }
    
    
}
