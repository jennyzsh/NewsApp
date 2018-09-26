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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resetContent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    func resetContent() {

    }
    
    
}
