//
//  ContentViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/2/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import CocoaLumberjack

class ContentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    deinit {
        DDLogDebug("\(URL(string: #file)?.lastPathComponent ?? "") \(#function) +\(#line) \(NSStringFromClass(Self.self))")
    }
}
