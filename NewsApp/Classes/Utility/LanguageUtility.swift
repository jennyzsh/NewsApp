//
//  LanguageUtility.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

enum AppLanguage: Int {
    case en = 0
    case tc
    case sc
}

class LanguageUtility: NSObject {
    
    static var lang: AppLanguage = getInitialLanguage() {
        didSet {
            UserDefaults.standard.set(lang.rawValue, forKey: GlobalConst.UserDefault_Language)
        }
    }
    
    static private func getInitialLanguage() -> AppLanguage {
        let lang = UserDefaults.standard.object(forKey: GlobalConst.UserDefault_Language)
        var appLang = LanguageUtility.getDevicePreferredLanguage()
        if lang != nil {
            appLang = AppLanguage(rawValue: lang as! Int)!
        }
        
        return appLang
    }
    
    static private func getDevicePreferredLanguage() -> AppLanguage {
        let locale = Locale.preferredLanguages[0]
        if locale.contains("zh-Hant") {
            return AppLanguage.tc
        } else if locale.contains("zh_Hans") {
            return AppLanguage.sc
        } else {
            return AppLanguage.en
        }
    }
    
    static func getCurrentLanguage() -> AppLanguage {
        return lang
    }
    

}
