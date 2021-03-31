//
//  HybridLib.swift
//  HybridLib
//
//  Created by Rake Yang on 2021/3/17.
//

import Foundation
import SwiftPodLib

public class HybridSwiftVersion: NSObject {
    
    /// 验证
    @objc public static func verification() -> Bool {
        return YHHybridLib.verification() && SwiftPodLib.verification() && NSDate(string: "2021-03-31", format: "yyyy-MM-dd")!.year == 2021
    }
    
    @objc public static func valid() -> Bool {
        return true
    }
}
