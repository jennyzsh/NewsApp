//
//  ViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 24/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class ViewController: BaseViewController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController

    }
    
    override func viewDidAppear(_ animated: Bool) {
        NetworkManager.instance.requestData(type: .GET, URLString: "http://v.juhe.cn/weather/index", finish: { (result) in
            print(result["reason"] as! String)
        }, success: { (json) in
            print("success!!")
        }, fail: { (error) in
            print("error!!")
        })
        
        
    }
    
    


}

