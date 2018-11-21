//
//  LoginViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/20.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var tfAccountName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
    }
    
    func setupLayout() {
        let account_image_view = UIImageView(image: UIImage(named: "login_account"))
        account_image_view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        account_image_view.contentMode = .center
        self.tfAccountName.leftView = account_image_view
        self.tfAccountName.leftViewMode = .always
        self.tfAccountName.placeholder = "User Name"
        
        let pwd_image_view = UIImageView(image: UIImage(named: "login_password"))
        pwd_image_view.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        pwd_image_view.contentMode = .center
        self.tfPassword.leftView = pwd_image_view
        self.tfPassword.leftViewMode = .always
        self.tfPassword.placeholder = "Password"
    }

    @IBAction func didPressBtnLogin(_ sender: UIButton) {
        var params: [String: Any] = [:]
        params["username"] = self.tfAccountName.text! as Any
        params["password"] = self.tfPassword.text! as Any
        params["uuid"] = LoginManager.uuid as Any

        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/login", parameters: params) { (json) in
            
            print(json["userID"]!)
        }
        
    }
        
    
}
