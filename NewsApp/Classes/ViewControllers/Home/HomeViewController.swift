//
//  HomeViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func resetContent() {
        super.resetContent()
        self.navigationController?.navigationBar.topItem?.title = StringUtility.getStringOf(keyName: "Home")
    }

}
