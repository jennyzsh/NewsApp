//
//  NoteViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 27/9/18.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class NoteViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func resetContent() {
        super.resetContent()
        self.navigationController?.navigationBar.topItem?.title = StringUtility.getStringOf(keyName: "Note")

    }
}
