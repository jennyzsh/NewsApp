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
        self.navigationController?.navigationBar.barTintColor = UIColor.red
        


    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //        self.navigationController?.navigationBar.tintColor = Color.HeaderGray

    }
}
