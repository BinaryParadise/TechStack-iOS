//
//  PureSwiftLib.swift
//  PureSwiftLib
//
//  Created by Rake Yang on 2021/3/17.
//

import Foundation
import SwiftPodLib

public class PureSwiftVersion {
    /// 验证
    public static func verification() -> Bool {
        return SwiftPodLib.verification() && NSDate(string: "2021-03-31", format: "yyyy-MM-dd")?.year == 2021
    }
}
