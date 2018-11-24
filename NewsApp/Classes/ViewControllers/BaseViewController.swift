//
//  BaseViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/9/24.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupObserver()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.resetContent()
    }
    
    @objc func resetContent() {
        self.setNavigationBarBackground(color: Color.themeColorList[Color.themeColor.rawValue])
        self.setNavigationBarRightButtonItem(nil)
        self.setNavigationBarLeftButtonItem(nil)

    }
    
    @objc func updateAppIconBadgeNumber() {
        UIApplication.shared.applicationIconBadgeNumber = BadgeManager.applicationIconBadgeNumber
    }
    
    @objc func restartApp() {
        UIApplication.shared.keyWindow?.rootViewController = UINavigationController(rootViewController: TabBarController())
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.restartApp), name: NSNotification.Name(rawValue: NotificationKey.Language_Did_Change_Notify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.resetContent), name: Notification.Name(rawValue: NotificationKey.ThemeColor_Did_Change_Notify), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.updateAppIconBadgeNumber), name: Notification.Name(rawValue: NotificationKey.AppIconBadgeNum_Did_Change_Notify), object: nil)

    }
    
    //MARK: - customize navigation bar
    func setNavigationBarBackground(color: UIColor) {
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    func setNavigationBarTitleView(_ titleView: UIView) {
        self.navigationController?.navigationBar.topItem?.titleView = titleView
    }
    
    func setNavigationBarRightButtonItem(_ rightButtonItem: UIBarButtonItem?) {
        self.navigationController?.navigationBar.topItem?.setLeftBarButtonItems(nil, animated: false)
        self.navigationController?.navigationBar.topItem?.setRightBarButton(rightButtonItem, animated: true)
    }
    
    func setNavigationBarLeftButtonItem(_ leftButtonItem: UIBarButtonItem?) {
        self.navigationController?.navigationBar.topItem?.setRightBarButtonItems(nil, animated: false)
        self.navigationController?.navigationBar.topItem?.setLeftBarButton(leftButtonItem, animated: true)
    }
    

    
    
}
