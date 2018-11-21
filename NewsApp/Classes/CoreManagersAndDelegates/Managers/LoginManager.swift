//
//  LoginManager.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/21.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class LoginManager: NSObject {
    
//    static let instance = LoginManager()
    
    static var username: String = getUsername() {
        didSet {
            UserDefaults.standard.set(username, forKey: GlobalConst.UserDefault_UserName)
        }
    }
    
    static private func getUsername() -> String {
        let name = UserDefaults.standard.object(forKey: GlobalConst.UserDefault_UserName)
        if name == nil {
            return ""
        }
        return name as! String
    }
    
    static var password: String = getPassword() {
        didSet {
            UserDefaults.standard.set(password, forKey: GlobalConst.UserDefault_Password)
        }
    }
    
    static private func getPassword() -> String {
        let pw = UserDefaults.standard.object(forKey: GlobalConst.UserDefault_Password)
        if pw == nil {
            return ""
        }
        return pw as! String
    }
    
    static var userID: Int = getUserID() {
        didSet {
            UserDefaults.standard.set(userID, forKey: GlobalConst.UserDefault_UserID)
        }
    }
    
    static private func getUserID() -> Int {
        let userID = UserDefaults.standard.object(forKey: GlobalConst.UserDefault_UserID)
        if userID == nil {
            return -1
        }
        return userID as! Int
    }
    
    static var uuid: String = (UIDevice.current.identifierForVendor?.uuidString)!
    
}
