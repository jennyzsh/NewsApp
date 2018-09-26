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

        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        vcList.append(homeViewController)
        
        let meViewController = MeViewController()
        meViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        vcList.append(meViewController)
        
        self.viewControllers = vcList
        
        

    }
}
