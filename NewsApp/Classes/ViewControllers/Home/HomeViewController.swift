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
        self.navigationController?.navigationBar.topItem?.title = StringUtility.getStringOf(keyName: "Home")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //        let navController = UINavigationController(rootViewController: SelectThemeColorViewController())
        //        self.present(navController, animated: true, completion: nil)
        let navController = UINavigationController(rootViewController: SearchViewController())
        self.present(navController, animated: true, completion: nil)
    }
    
    


}
