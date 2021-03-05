//
//  ContentViewController.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/2/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit
import CocoaLumberjack
import SnapKit

func ScreenWidth() -> CGFloat {
    return UIScreen.main.bounds.width
}

func ScreenHeight() -> CGFloat {
    return UIScreen.main.bounds.height
}

class ContentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hex: 0xF4F5F6)
        
    }
    
    deinit {
        DDLogDebug("\(URL(string: #file)?.lastPathComponent ?? "") \(#function) +\(#line) \(NSStringFromClass(Self.self))")
    }
}
