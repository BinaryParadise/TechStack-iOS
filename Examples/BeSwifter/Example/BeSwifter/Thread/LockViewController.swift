//
//  LockViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Peregrine

class LockViewController: LoggerViewController {
    var inventory: Int = 0
    var switchOn = UISwitch()
    
    var isLockOn: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(switchOn)
        switchOn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(loggerView.snp.top).offset(-10)
        }
        switchOn.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
    }
    
    @objc func switchChanged() {
        isLockOn = switchOn.isOn
    }
    
    override func onActionButton() {
        super.onActionButton()
        let alert = UIAlertController(title: nil, message: "选择类型", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "NSLock", style: .default, handler: { (action) in
            self.cueNSLock()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func cueNSLock() {
        inventory = 10
        let lock = NSLock()
        
        for _ in 0...inventory {
            DispatchQueue.global().async { [weak self] in
                guard let self = self else { return }
                if self.isLockOn {
                    if lock.try() {
                        self.saleSkins()
                        lock.unlock()
                    }
                } else {
                    self.saleSkins()
                }
            }
        }
    }
    
    func saleSkins() {
        if inventory == 0 {
            appendText(text: "手套卖光了，下次记得早点来哦")
        } else {
            inventory -= 1
            appendText(text: "运动手套 | 迈阿密风云已售出，剩余库存\(inventory)")
        }
    }
}

extension LockViewController {
    @available(*, renamed: "route", message: "swift://thread/lock")
    @objc static func lockDemo(context: RouteContext) -> Void {
        pushViewController(controller: LockViewController())
    }
}
