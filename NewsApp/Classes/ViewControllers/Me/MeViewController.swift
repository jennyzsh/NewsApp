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
        self.navigationController?.navigationBar.topItem?.title = StringUtility.getStringOf(keyName: "Me")
    }
    
    @IBAction func didClickBtnEN(_ sender: UIButton) {
        LanguageUtility.lang = .en
        print("Select EN")
    }
    
    @IBAction func didClickBtnTC(_ sender: UIButton) {
        LanguageUtility.lang = .tc
        print("Select TC")
    }
    
    @IBAction func didClickBtnSC(_ sender: UIButton) {
        LanguageUtility.lang = .sc
        print("Select SC")
    }
}
