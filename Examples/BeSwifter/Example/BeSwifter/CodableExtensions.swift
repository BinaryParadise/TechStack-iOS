//
//  CodableExtensions.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/2/20.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import CocoaLumberjack
import CommonCrypto

extension Data {
    func decode<T>(_ type: T.Type) -> T? where T : Decodable {
        do {
            return try JSONDecoder().decode(type, from: self)
        } catch {
//            DDLogError("\(error)")
        }
        return nil
    }
}

extension String {
    var sha256: Data {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        CC_SHA256(utf8, CC_LONG(utf8!.count - 1), &digest)
        return Data(bytes: digest)
    }
}
