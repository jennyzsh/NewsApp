//
//  MeViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func resetContent() {
        super.resetContent()
        self.navigationController?.navigationBar.topItem?.title = StringUtility.getStringOf(keyName: "Me")        
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
//        let navController = UINavigationController(rootViewController: SelectThemeColorViewController())
//        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func didClickBtnSelectLang(_ sender: UIButton) {
        self.selectLanguage()
    }
    
    @IBAction func didPressBtnSelectThemeColor(_ sender: UIButton) {
        self.selectThemeColor()
    }
    
    
}
