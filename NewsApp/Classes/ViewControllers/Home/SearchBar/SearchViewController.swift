//
//  SearchViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 28/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //set up Navigation Bar TitleView
        let lblTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
        lblTitle.sizeToFit()
        lblTitle.text =  StringUtility.getStringOf(keyName: "Search")
        lblTitle.textAlignment = .center
        lblTitle.font = UIFont.systemFont(ofSize: 18)
        self.setNavigationBarTitleView(lblTitle)
        
        //set up Navigation Bar Right BarButton Item
        let dismiss = UIBarButtonItem(title: "XXXX", style: .plain, target: self, action: #selector(SearchViewController.didPressRightBarButton))
        dismiss.tintColor = Color.White
        self.setNavigationBarRightButtonItem(dismiss)
        
        //set up Navigation Bar Left BarButton Item
        let back = UIBarButtonItem(title: "<-", style: .plain, target: self, action: #selector(SearchViewController.didPressLeftBarButton))
        back.tintColor = Color.White
        self.setNavigationBarLeftButtonItem(back)

        self.setupSearchBar()
        
    }
    
    func setupSearchBar() {
        var searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Now"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.navigationItem.searchController = searchController
        
        searchController.searchBar.tintColor = Color.White
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
    }
    
    @objc func didPressRightBarButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didPressLeftBarButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
