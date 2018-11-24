//
//  AlertUtility.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/24.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class AlertUtility: NSObject {
    
    static func presentOneButtonSimpleAlert(title: String, msg: String, buttonTitle: String, callback: ((UIAlertAction)->Void)?) {
        // create the alert
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler: callback))
        
        // show the alert
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    static func presentTwoButtonAlert(title: String, msg: String, cancelButton: String, cancelCallback: ((UIAlertAction)->Void)?, confirmButton: String, confirmCallback: ((UIAlertAction)->Void)?){
        
        // create the alert
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: confirmButton, style: UIAlertAction.Style.default, handler: confirmCallback))
        alert.addAction(UIAlertAction(title: cancelButton, style: UIAlertAction.Style.cancel, handler: cancelCallback))
        
        // show the alert
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }

}
