//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self 
    }
    
    override func resetContent() {
        super.resetContent()
     
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Home")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if let tabItems = tabBarController?.tabBar.items {
//            let tabItem = tabItems[1]
//            tabItem.badgeValue = "NEW"
//        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let navController = UINavigationController(rootViewController: SearchViewController())
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func didPressIncreaseBadge(_ sender: UIButton) {
        BadgeManager.applicationIconBadgeNumber += 1
    }
    
    @IBAction func didPressResetBadge(_ sender: UIButton) {
        BadgeManager.resetAppIconBadgeNumber()
    }
    

}
