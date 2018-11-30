//
//  TabBarController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    var vcList: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupObserver()
        self.changeThemeColor()
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: StringUtility.getStringOf(keyName: "Home"), image: UIImage(named: "home"), tag: 0)
        vcList.append(homeViewController)
        
        let subscribeViewController = SubscribeViewController()
        subscribeViewController.tabBarItem = UITabBarItem(title: StringUtility.getStringOf(keyName: "Subscribe"), image: UIImage(named: "subscribe"), tag: 1)
        vcList.append(subscribeViewController)
        
        let noteViewController = NoteViewController()
        noteViewController.tabBarItem = UITabBarItem(title: StringUtility.getStringOf(keyName: "Note"), image: UIImage(named: "note"), tag: 2)
        vcList.append(noteViewController)
        
        let meViewController = MeViewController()
        meViewController.tabBarItem = UITabBarItem(title: StringUtility.getStringOf(keyName: "Me"), image: UIImage(named: "me"), tag: 3)
        vcList.append(meViewController)
        
        self.viewControllers = vcList
        
        self.selectedIndex = 1
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(TabBarController.changeThemeColor), name: Notification.Name(NotificationKey.ThemeColor_Did_Change_Notify), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(TabBarController.updateTabBarBadgeNumber), name: Notification.Name(rawValue: NotificationKey.AppIconBadgeNum_Did_Change_Notify), object: nil)

    }
    
    @objc func changeThemeColor() {
        UITabBar.appearance().tintColor = Color.themeColorList[Color.themeColor.rawValue]
    }
    
    @objc func updateTabBarBadgeNumber() {
        if let tabItems = self.tabBar.items {
            let tabItem = tabItems[0]
            tabItem.badgeValue = BadgeManager.applicationIconBadgeNumber == 0 ? nil : "\(BadgeManager.applicationIconBadgeNumber)"
        }
    }
}
