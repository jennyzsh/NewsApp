//
//  NewsObj.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/23.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewsContentObj: NSObject {
    var content = ""
    var type = ""
}

class NewsObj: NSObject {
    
    var newsID = -1
    var publisher = ""
    var dislike_num = 0
    var like_num = 0
    var author = ""
    var title = ""
    var time = ""
    var content: [JSON] = []

}
