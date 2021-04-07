//
//  SemaphoreViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Peregrine

let player1 = "【1】电脑玩家炸鱼哥"
let player2 = "【2】电脑玩家垃圾君"
let player3 = "【3】电脑玩家菜的抠脚"
let player4 = "【4】电脑玩家句号哥"

/// 信号量
class SemaphoreViewController: LoggerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func onActionButton() {
        appendText(text: "匹配开始...")
        
        let sema = DispatchSemaphore(value: 0)
        DispatchQueue.global().async { [weak self] in
            if sema.wait(timeout: .now()+2) == .success {
                self?.appendText(text: "任务1收到信号")
            } else {
                self?.appendText(text: "\(player1) 等了2秒不耐烦就去玩原神了")
            }
        }
        
        DispatchQueue.global().async { [weak self] in
            if sema.wait(wallTimeout: .now()+4) == .success {
                self?.appendText(text: "任务2收到信号")
            } else {
                self?.appendText(text: "\(player4) 等了4秒还是没有车位就去PJ了")
            }
        }
        
        DispatchQueue.global().async { [weak self] in
            sema.wait()
            self?.appendText(text: "\(player2) 不离不弃最终等到了车位")
        }
        
        DispatchQueue.global().async { [weak self] in
            sleep(5)
            self?.appendText(text: "\(player3) 由于太菜被踢下车")
            if sema.signal() < 0 {
                self?.appendText(text: "等待中")
            }
        }
        appendText(text: "玩家等待车位中")
    }
}

extension SemaphoreViewController {
    @available(*, renamed: "route", message: "swift://thread/semaphore")
    @objc static func semaphoreDemo(context: RouteContext) -> Void {
        pushViewController(controller: SemaphoreViewController())
        context.onFinished()
    }
}
