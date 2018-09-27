//
//  Color.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 27/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

//should be updated with Color.themeColorList
enum ThemeColor: Int {
    case Green = 0
    case Blue
    case Red
    case Pink
    case Orange
}

class Color: NSObject {
    
    static var themeColor: ThemeColor = getThemeColor(){
        didSet{
            UserDefaults.standard.set(themeColor.rawValue, forKey: GlobalConst.UserDefault_ThemeColor)
        }
    }
    
    static let themeColorList = [Color.Green,
                                 Color.Blue,
                                 Color.Red,
                                 Color.Pink,
                                 Color.Orange]
    
    static let Green            = UIColor.init( 91, 171,  38, 1)
    static let Blue             = UIColor.init(  0,   0, 255, 1)
    static let Red              = UIColor.init(236,  40,  53, 1)
    static let Gray             = UIColor.init(100, 100, 100, 1)
    static let Pink             = UIColor.init(200,  50,  50, 1)
    static let White            = UIColor.init(255, 255, 255, 1)
    static let Orange           = UIColor.init(252, 107,   7, 1)
    
    
    static private func getThemeColor() -> ThemeColor {
        let themeColor = UserDefaults.standard.object(forKey: GlobalConst.UserDefault_ThemeColor)
        if themeColor == nil {
            return ThemeColor(rawValue: 0)!
        }
        return ThemeColor(rawValue: themeColor as! Int)!
    }

}
