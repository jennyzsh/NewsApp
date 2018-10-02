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
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //        let navController = UINavigationController(rootViewController: SelectThemeColorViewController())
        //        self.present(navController, animated: true, completion: nil)
        let navController = UINavigationController(rootViewController: SearchViewController())
        self.present(navController, animated: true, completion: nil)
    }
    
    


}
