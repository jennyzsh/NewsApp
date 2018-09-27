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
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        vcList.append(homeViewController)
        
        let subscribeViewController = SubscribeViewController()
        subscribeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        vcList.append(subscribeViewController)
        
        let noteViewController = NoteViewController()
        noteViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        vcList.append(noteViewController)
        
        let meViewController = MeViewController()
        meViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
        vcList.append(meViewController)
        
        self.viewControllers = vcList
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(TabBarController.changeThemeColor), name: Notification.Name(NotificationKey.ThemeColor_Did_Change_Notify), object: nil)
    }
    
    @objc func changeThemeColor() {
        UITabBar.appearance().tintColor = Color.themeColorList[Color.themeColor.rawValue]
    }
    
}
