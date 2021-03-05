//
//  SemaphoreViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/4.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import Peregrine

class SemaphoreViewController: LoggerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SemaphoreViewController {
    @available(*, renamed: "route", message: "swift://thread/lock/semaphore")
    @objc static func semaphoreDemo(context: RouteContext) -> Void {
        
    }
}
