//
//  StringUtility.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 26/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class StringUtility: NSObject {
    
    static func getStringOf(keyName: String) -> String {
        let dic = plistDictionary()
        let text = dic.value(forKey: keyName) as? String
        if text != nil {
            return text!
        } else {
            return keyName
        }
    }
    
    static fileprivate func plistDictionary() -> NSDictionary {
        let path = Bundle.main.bundlePath
        var fileName = ""
        switch LanguageUtility.getCurrentLanguage() {
        case .en:
            fileName = "/Strings_EN.plist"
        case .tc:
            fileName = "/Strings_TC.plist"
        case .sc:
            fileName = "/Strings_SC.plist"
        }
        
        let finalPath = path + fileName
        let dic = NSDictionary(contentsOfFile: finalPath)!
        return dic
    }

}
