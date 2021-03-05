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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loggerView)
        loggerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
}
