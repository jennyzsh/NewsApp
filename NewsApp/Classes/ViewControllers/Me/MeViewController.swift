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
        self.navigationController?.navigationBar.barTintColor = UIColor.green
        self.navigationController?.navigationBar.topItem?.title = "Me"

    }

}
