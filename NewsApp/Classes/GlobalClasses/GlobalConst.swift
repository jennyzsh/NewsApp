//
//  GlobalConst.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

//MARK: - Notification Key
struct NotificationKey {
    static let Language_Did_Change_Notify    = "LanguageDidChangeNotify"
    static let ThemeColor_Did_Change_Notify  = "ThemeColorDidChangeNotify"
    static let AppIconBadgeNum_Did_Change_Notify = "AppIconBadgeNumDidChangeNotify"
}

class GlobalConst: NSObject {
    
    static let UserDefault_Language          = "UserDefault_Language"
    static let UserDefault_ThemeColor        = "UserDefault_ThemeColor"
    static let UserDefault_AppIconBadgeNum   = "UserDefault_AppIconBadgeNum"
    static let UserDefault_UserName          = "UserDefault_UserName"
    static let UserDefault_Password          = "UserDefault_Password"
    static let UserDefault_UserID            = "UserDefault_UserID"
    static let UserDefault_Uuid              = "UserDefault_Uuid"

}
