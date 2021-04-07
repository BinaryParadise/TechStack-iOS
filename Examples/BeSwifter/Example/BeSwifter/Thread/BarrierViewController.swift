//
//  BarrierViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Peregrine

/// 栅栏
class BarrierViewController: LoggerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "barrier"
    }
    
    override func onActionButton() {
        super.onActionButton()
        
        let queue = DispatchQueue(label: "串行队列", attributes: .concurrent)
        queue.async { [weak self] in
            self?.appendText(text: "\(player1) 上车了")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player2) 上车了")
        }
        
        queue.async(flags: .barrier) { [weak self] in
            sleep(3)
            self?.appendText(text: "\(player3) 强行插队，年轻人不讲武德")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player4) 在 \(player3) 之后也上车了")
        }
    }
}

extension BarrierViewController {
    @available(*, renamed: "route", message: "swift://thread/barrier")
    @objc static func barrierDemo(context: RouteContext) -> Void {
        pushViewController(controller: BarrierViewController())
    }
}
