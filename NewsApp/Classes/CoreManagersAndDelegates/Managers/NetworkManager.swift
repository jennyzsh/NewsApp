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
    
    func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : JSON) -> ()) {
        
        // 1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post

        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in

            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)
                return
            }

            // 4.将结果回调出去
            let json = JSON(response.result.value)
            finishedCallback(json)
            
        }

    }
    

}
