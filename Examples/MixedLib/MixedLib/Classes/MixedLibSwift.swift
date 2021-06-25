//
//  MixedLibSwift.swift
//  MixedLib
//
//  Created by Rake Yang on 2021/4/19.
//

import Foundation
import PureSwiftLib
import YYCategories

@objc public enum FollowStatus: Int {
    case none = 0
    case follow = 1
}

public class MixedLibSwift: NSObject {
    @objc public static func verification() -> Bool {
        return PureSwiftVersion.verification()
            && NSDate().isToday
            && YHHybridLib.verification()
    }
}
 
