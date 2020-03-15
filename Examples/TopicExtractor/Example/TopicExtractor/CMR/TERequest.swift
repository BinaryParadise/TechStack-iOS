//
//  TERequest.swift
//  TopicExtractor_Example
//
//  Created by Rake Yang on 2020/3/14.
//  Copyright © 2020年 CocoaPods. All rights reserved.
//

import Foundation

public extension URLRequest {
    func requestIncludeBody() -> URLRequest {
        if httpMethod == "POST" {
            let request = (self as NSURLRequest).mutableCopy() as! NSMutableURLRequest
            let stream = request.httpBodyStream
            let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 1024)
            let mdata = NSMutableData.init()
            var bytesRead = 0
            stream?.open()
            repeat {
                bytesRead = stream?.read(buffer, maxLength: 1024) ?? 0
                if bytesRead > 0 {
                    mdata.append(buffer, length: bytesRead)
                }
            } while bytesRead == 1024
            
            request.httpBody = mdata.copy() as? Data
            stream?.close()
            return request as URLRequest
        }
        return self
    }
}
