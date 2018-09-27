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
        self.setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.resetContent()
    }
    
    @objc func resetContent() {
        self.navigationController?.navigationBar.barTintColor = UIColor.red
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.resetContent), name: NSNotification.Name(rawValue: NotificationKey.Language_Did_Change_Notify), object: nil)
    }
    
    
}
