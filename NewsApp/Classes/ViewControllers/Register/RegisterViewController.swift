//
//  RegisterViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/21.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var tfAccountName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var lblRegisterError: UILabel!
    
    
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
        
        self.lblWelcome.text = StringUtility.getStringOf(keyName: "Welcome")
        self.btnRegister.setTitle(StringUtility.getStringOf(keyName: "Login"), for: .normal)
        self.btnRegister.setTitle(StringUtility.getStringOf(keyName: "Register"), for: .normal)
        
        self.lblRegisterError.text = StringUtility.getStringOf(keyName: "RegisterError")
        self.lblRegisterError.isHidden = true
    }

    @IBAction func didPressBtnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didPressBtnRegister(_ sender: UIButton) {
        var params: [String: Any] = [:]
        params["username"] = self.tfAccountName.text! as Any
        params["password"] = self.tfPassword.text! as Any
        
        NetworkManager.instance.requestData(.POST, URLString: "http://127.0.0.1:5000/logon", parameters: params) { (json) in
            
            if json["returnCode"] as! Int == 0 {
                self.lblRegisterError.isHidden = false
            } else {
                LoginManager.username = self.tfAccountName.text!
                LoginManager.password = self.tfPassword.text!
                self.lblRegisterError.isHidden = true
                print("Register Success")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
