//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/9/24.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum MethodType {
    case GET
    case POST
}

class NetworkManager: NSObject {
    static let instance = NetworkManager()
    
    func requestData(type : MethodType, URLString : String, parameters : [String : Any]? = nil, finish: @escaping((_ result: [String: Any]) -> ()), success: @escaping((_ response: [String: Any]) -> ()), fail: @escaping((_ error: [String: Any]) -> ())) {

        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(URLString, method: method, parameters: parameters)
            .responseJSON { (response) in

                if let result = response.result.value as? [String: Any] {
                    
                    finish(result)
                    
                    if response.result.isSuccess {
                        success(result)
                    } else if response.result.isFailure {
                        fail(result)
                    } else {
                        
                    }
                }
        }
    }
}
