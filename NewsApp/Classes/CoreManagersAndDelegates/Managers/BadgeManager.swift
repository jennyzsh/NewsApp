//
//  BadgeManager.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2/10/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class BadgeManager: NSObject {
    
    //MARK: - Application Badge
    static var applicationIconBadgeNumber: Int = getApplicationIconBadgeNumber() {
        didSet {
            UserDefaults.standard.set(applicationIconBadgeNumber, forKey: GlobalConst.UserDefault_AppIconBadgeNum)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationKey.AppIconBadgeNum_Did_Change_Notify), object: nil)
        }
    }
    
    static private func getApplicationIconBadgeNumber() -> Int {
        let num = UserDefaults.standard.object(forKey: GlobalConst.UserDefault_AppIconBadgeNum)
        if num == nil {
            return 0
        }
        return num as! Int
    }

    static func resetAppIconBadgeNumber() {
        BadgeManager.applicationIconBadgeNumber = 0
    }

}
