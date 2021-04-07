//
//  MixedLibSwift.swift
//  MixedLib
//
//  Created by Rake Yang on 2021/4/19.
//

import Foundation
import PureSwiftLib
import YYCategories
// 验证
//import lib_objectivec //Could not build Objective-C module 'lib_objectivec'
import LibObjectivec
import LibSwifter

public class MixedLibSwift: NSObject {
    @objc public static func verification() -> Bool {
        return PureSwiftVersion.verification()
            && NSDate().isToday
            && LibObjectivec.LOFactory.verify()
            && LibSwifterVersion.verify()
    }
}
 
