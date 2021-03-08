//
//  LoggerViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

class LoggerViewController: ContentViewController {
    let loggerView = UITextView()
    let actionButton = UIButton(type: .custom)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actionButton.layer.cornerRadius = 5
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        actionButton.backgroundColor = .systemPink
        actionButton.setTitle("Start", for: .normal)
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(onActionButton), for: .touchUpInside)
        actionButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(NavHeight()+12)
            make.height.equalTo(30)
        }
        
        loggerView.isEditable = false
        view.addSubview(loggerView)
        loggerView.snp.makeConstraints { (make) in
            make.top.equalTo(actionButton.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func appendText(text: String) {
        DispatchQueue.main.async { [weak self] in
            let mattr = NSMutableAttributedString()
            mattr.append(NSAttributedString(string: Date().string(withFormat: "yyyy-MM-dd HH:mm:ss "), attributes: [.foregroundColor: UIColor.systemPink]))
            mattr.append(NSAttributedString(string: "\(text)\n"))
            self?.loggerView.textStorage.append(mattr)
        }
    }
    
    func clearText() {
        loggerView.clear()
    }
    
    @objc func onActionButton() {
        
    }
}
