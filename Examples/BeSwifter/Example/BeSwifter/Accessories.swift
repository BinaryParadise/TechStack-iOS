//
//  Accessories.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/2/19.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import CocoaLumberjack

/// 步枪
class Rifle {
    var name: String = ""
    var wear: Double = 0
    var painting: String = "无"
    
    var matchKnife: Knife?
    
    var description: String {
        return "\(name) | \(painting) \(wear)"
    }
    
    deinit {
//        DDLogWarn("\(#function) +\(#line) \(self)")
    }
}

class Knife {
    var name: String = ""
    var wear: Double = 0
    var painting: String = "无"
    
    var matchRifle: Rifle?
    
    var description: String {
        return "\(name) | \(painting) \(wear)"
    }
    
    deinit {
//        DDLogWarn("\(#function) +\(#line) \(self)")
    }
}
