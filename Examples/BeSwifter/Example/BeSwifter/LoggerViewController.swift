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
    let timeLabel = UILabel()
    
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
            make.height.equalToSuperview().multipliedBy(0.5)
            make.left.right.bottom.equalToSuperview()
        }
        
        let lineView = UIView()
        lineView.backgroundColor = .orange
        view.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalTo(loggerView.snp.top)
        }
        
        timeLabel.textColor = .orange
        timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(actionButton)
            make.right.equalToSuperview().offset(-20)
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
    }
    
    func appendText(text: String) {
        DispatchQueue.main.async { [weak self] in
            let mattr = NSMutableAttributedString()
            mattr.append(NSAttributedString(string: Date().string(withFormat: "yyyy-MM-dd HH:mm:ss "), attributes: [.foregroundColor: UIColor.purple]))
            mattr.append(NSAttributedString(string: "\(text)\n"))
            self?.loggerView.textStorage.append(mattr)
        }
    }
    
    func clearText() {
        loggerView.clear()
    }
    
    @objc func onActionButton() {
        clearText()
    }
    
    @objc func onTimer() {
        timeLabel.text = "\(Date().string(withFormat: "yy.MM.dd HH:mm:ss.SSS"))"
    }
}
