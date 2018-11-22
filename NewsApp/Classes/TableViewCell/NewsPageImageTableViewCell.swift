//
//  NewsPageImageTableViewCell.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/22.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsPageImageTableViewCell: UITableViewCell {

    @IBOutlet weak var ivContent: UIImageView!
    
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
        
        self.ivContent.af_setImage(withURL: url, completion:{ dataResponse in
            
            self.ivContent.image = dataResponse.result.value
        })
    }

}
