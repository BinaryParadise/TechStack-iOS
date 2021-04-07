//
//  MultiThreadViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/9.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Peregrine

/// GCD多线程
class MultiThreadViewController: LoggerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GCD"
    }
    
    override func onActionButton() {
        super.onActionButton()
        
        let alert = UIAlertController(title: nil, message: "选择类型", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "主队列-同步", style: .destructive, handler: { [weak self] (action) in
            self?.mainSync()
        }))
        alert.addAction(UIAlertAction(title: "主队列-异步", style: .default, handler: { [weak self] (action) in
            self?.mainAsync()
        }))
        alert.addAction(UIAlertAction(title: "串行队列-同步", style: .default, handler: { [weak self] (action) in
            self?.queueSerialSync()
        }))
        alert.addAction(UIAlertAction(title: "串行队列-异步", style: .default, handler: { [weak self] (action) in
            self?.queueSerialAsync()
        }))
        alert.addAction(UIAlertAction(title: "并行队列-同步", style: .default, handler: { [weak self] (action) in
            self?.queueConcurrentSync()
        }))
        alert.addAction(UIAlertAction(title: "并行队列-异步", style: .default, handler: { [weak self] (action) in
            self?.queueConcurrentAsync()
        }))
        alert.addAction(UIAlertAction(title: "全局并行队列-同步", style: .default, handler: { [weak self] (action) in
            self?.queueGlobalSync()
        }))
        alert.addAction(UIAlertAction(title: "全局并行队列-异步", style: .default, handler: { [weak self] (action) in
            self?.queueGlobalAsync()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func mainSync() {
        appendText(text: "在主队列执行异步任务会阻塞主线程")
        DispatchQueue.main.sync {
            
        }
    }
    
    func mainAsync() {
        appendText(text: "主线执行耗时操作会阻塞主线程")
        DispatchQueue.main.async { [weak self] in
            for _ in 0...0x900000 {
                
            }
            self?.appendText(text: "执行完成")
        }
    }
    
    func queueSerialSync() {
        let queue = DispatchQueue(label: "串行队列")
        appendText(text: "串行队列同步执行耗时操作会阻塞【主线程】")
        queue.sync { [weak self] in
            for _ in 0...0x900000 {
                
            }
            self?.appendText(text: "\(player1) 完成了每日练枪任务")
        }
        
        queue.sync { [weak self] in
            self?.appendText(text: "\(player2) 完成了每日练枪任务")
        }
    }
    
    func queueSerialAsync() {
        let queue = DispatchQueue(label: "串行队列")
        appendText(text: "串行队列异步执行不阻塞【主线程】，有序完成")
        queue.async { [weak self] in
            for _ in 0...0x900000 {
                
            }
            self?.appendText(text: "\(player1) 完成了每日练枪任务")
        }
        
        queue.async { [weak self] in
            sleep(1)
            self?.appendText(text: "\(player2) 完成了每日练枪任务")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player3) 完成了每日练枪任务")
        }
    }
    
    func queueConcurrentSync() {
        let queue = DispatchQueue(label: "并行队列", attributes: .concurrent)
        appendText(text: "并行队列同步执行耗时操作会阻塞【主线程】，有序完成")
        queue.sync { [weak self] in
            self?.appendText(text: "\(player1) 完成了每日练枪任务")
        }
        
        queue.sync { [weak self] in
            for _ in 0...0x900000 {
                
            }
            self?.appendText(text: "\(player2) 完成了每日练枪任务")
        }
        
        queue.sync { [weak self] in
            self?.appendText(text: "\(player3) 完成了每日练枪任务")
        }
    }
        
    func queueConcurrentAsync() {
        let queue = DispatchQueue(label: "并行队列", attributes: .concurrent)
        appendText(text: "并行队列异步执行不阻塞【主线程】，无序完成")
        queue.async { [weak self] in
            for _ in 0...0x900000 {
                
            }
            self?.appendText(text: "\(player1) 完成了每日练枪任务")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player2) 完成了每日练枪任务")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player3) 完成了每日练枪任务")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player4) 完成了每日练枪任务")
        }
    }
    
    func queueGlobalSync() {
        let queue = DispatchQueue.global()
        appendText(text: "全局并行队列同步执行耗时操作会阻塞【主线程】，有序完成")
        queue.sync { [weak self] in
            self?.appendText(text: "\(player1) 完成了每日练枪任务")
        }
        
        queue.sync { [weak self] in
            for _ in 0...0x900000 {
                
            }
            self?.appendText(text: "\(player2) 完成了每日练枪任务")
        }
        
        queue.sync { [weak self] in
            self?.appendText(text: "\(player3) 完成了每日练枪任务")
        }
    }
    
    func queueGlobalAsync() {
        let queue = DispatchQueue.global()
        appendText(text: "全局并行队列异步执行不阻塞【主线程】，无序完成")
        queue.async { [weak self] in
            for _ in 0...0x900000 {
                
            }
            self?.appendText(text: "\(player1) 完成了每日练枪任务")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player2) 完成了每日练枪任务")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player4) 完成了每日练枪任务")
        }
        
        queue.async { [weak self] in
            self?.appendText(text: "\(player3) 完成了每日练枪任务")
        }
    }
}

extension MultiThreadViewController {
    @available(*, renamed: "route", message: "swift://thread/multi")
    @objc static func multi(context: RouteContext) -> Void {
        pushViewController(controller: MultiThreadViewController())
    }
}
