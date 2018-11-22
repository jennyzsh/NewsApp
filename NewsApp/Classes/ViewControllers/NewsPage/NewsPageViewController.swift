//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by Jenny ZHANG on 2018/11/22.
//  Copyright © 2018年 Jenny ZHANG. All rights reserved.
//

import UIKit

class NewsPageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var vAddComment: UIView!
    @IBOutlet weak var vCommentArea: UIView!
    @IBOutlet weak var tvComment: UITextView!
    @IBOutlet weak var btnAddComment: UIButton!
    
    
    
    let textCellIdentifier = "NewsPageTextTableViewCell"
    let imageCellIdentifier = "NewsPageImageTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName: textCellIdentifier, bundle: nil), forCellReuseIdentifier: textCellIdentifier)
        self.tableView.register(UINib(nibName: imageCellIdentifier, bundle: nil), forCellReuseIdentifier: imageCellIdentifier)
    }
    
    func setupLayout() {
        self.btn1.setTitle(StringUtility.getStringOf(keyName: "AddComment"), for: .normal)
        self.btn2.setTitle(StringUtility.getStringOf(keyName: "ViewComment"), for: .normal)
        self.btnAddComment.setTitle(StringUtility.getStringOf(keyName: "Send"), for: .normal)
        self.vAddComment.isHidden = true
        self.tvComment.layer.borderWidth = 1
        self.tvComment.layer.borderColor = Color.Gray.cgColor
        self.tvComment.layer.cornerRadius = 5
        
        let tapToDismissCommentView = UITapGestureRecognizer(target: self, action: #selector(dismissCommentView))
        self.vAddComment.addGestureRecognizer(tapToDismissCommentView)
    }
    
    @objc func dismissCommentView() {
        self.view.endEditing(true)
        self.vAddComment.isHidden = true
    }
    
    //MARK: UITextViewDelegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK: UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath) as! NewsPageTextTableViewCell
        
        return cell
    }

    @IBAction func didPressBtn1(_ sender: UIButton) {
        self.vAddComment.isHidden = false
    }
    
    @IBAction func didPressBtn2(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressBtnAddComment(_ sender: UIButton) {
        
    }
    
    
}
