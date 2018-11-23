//
//  SubscribeTableViewCell.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/21.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPublisher: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblLikeNum: UILabel!
    @IBOutlet weak var lblDislikeNum: UILabel!
    @IBOutlet weak var ivThumbnail: UIImageView!
    @IBOutlet weak var ivThumbnailConstraintW: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImageContent(with fileUrl:String?)
    {
        print(fileUrl ?? "No fileUrl")
        
        guard let fileURL = fileUrl,
            let url = URL(string: fileURL) else {
                return
        }
        
        self.ivThumbnail.af_setImage(withURL: url, completion:{ dataResponse in
            
            self.ivThumbnail.image = dataResponse.result.value
        })
    }

}
