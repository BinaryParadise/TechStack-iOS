//
//  SwifterJSExport.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/6/30.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import JavaScriptCore

class SwifterJSExport: JSExport {
    func timestamp() -> Int64 {
        return Int64(Date().timeIntervalSince1970*1000)
    }
}
