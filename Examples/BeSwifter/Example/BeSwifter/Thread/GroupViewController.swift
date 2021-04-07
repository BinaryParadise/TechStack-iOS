//
//  GroupViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/11.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import Peregrine

class GroupViewController: LoggerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Group"
    }
    
    override func onActionButton() {
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group, execute: DispatchWorkItem(block: { [weak self] in
            self?.appendText(text: "\(player1) 偷偷上车了")
        }))
        
        DispatchQueue.global().async(group: group, execute: DispatchWorkItem(block: { [weak self] in
            sleep(3)
            self?.appendText(text: "\(player2) 墨迹了一会也上车了")
        }))
        
        group.enter() //成对调用
        DispatchQueue.global().async { [weak self] in
            DispatchQueue.global().async { [weak self] in
                sleep(5)
                self?.appendText(text: "\(player3) 墨迹了很久没赶上车")
                group.leave()
            }
        }
                
        group.notify(queue: DispatchQueue.global(), work: DispatchWorkItem(block: { [weak self] in
            self?.appendText(text: "人终于到齐，发车了")
        }))
        appendText(text: "娱乐掉分车开始组队...")
    }
}


extension GroupViewController {
    @available(*, renamed: "route", message: "swift://thread/group")
    @objc static func groupDemo(context: RouteContext) -> Void {
        pushViewController(controller: GroupViewController())
    }
}
