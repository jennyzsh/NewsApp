//
//  SavedPassageTableViewCell.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/30.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class SavedPassageTableViewCell: UITableViewCell {

    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblPassage: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnDelete.setTitle(StringUtility.getStringOf(keyName: "Delete"), for: .normal)
    }

}
